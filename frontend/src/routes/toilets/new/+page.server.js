import { env } from "$env/dynamic/private"
import { fail, redirect, error } from "@sveltejs/kit"
import schemas from "../../../utils/schemas"
import f from "../../../utils/customFetch"

export async function load({ cookies }) {

  const headers = { Cookie: `_session=${cookies.get("_session")}` }
  const data = await f.get(`${env.API_URL}/api/login/verify`, headers)

  if (!data.ok) {
    if (data.status === 401) {
      return redirect(302, "/login") // TODO: notification, redirect
    }

    return error(500, "Error fetching user, please try again later.")
  }

  return { login: true }
}

export const actions = {

	newtoilet: async function ({ cookies, request }) {

		const data = await request.formData()

    const title = data.get("title")
    const university = data.get("university")
    const building = data.get("building")
    const place = data.get("place")
    const description = data.get("description")

    const valid = schemas.toilet.safeParse({ title, university, building, place, description })
    if (!valid.success) {
      const error = `Invalid ${valid.error.issues[0].path[0]}`
      return fail(400, { error })
    }

    const headers = { Cookie: `_session=${cookies.get("_session")}` }
    const response = await f.post(
      `${env.API_URL}/api/toilets/create`,
      headers,
      { title, university, building, place, description }
    )

    if (!response.ok) {
      if (data.status === 401) {
        return redirect(302, "/login") // TODO: notification, redirect
      }
      if (response.status === 400) {
        return fail(400, { error: "Error creating toilet" })
      }

      return error(500, "Error creating toilet.")
    }


		return redirect(302, "/toilets") // TODO: notification
  }
}
