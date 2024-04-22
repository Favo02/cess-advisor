import axios from "axios"
import { API_URL } from "$env/static/private"
import { fail, redirect, error } from "@sveltejs/kit"
import schemas from "../../../utils/schemas"

export async function load({ cookies }) {

  const headers = { Cookie: `_session=${cookies.get("_session")}` }

  try {
    await axios.get(`${API_URL}/api/login/verify`, { headers })
    return { loing: true }

  } catch (e) {
    if (e?.response?.status === 401) {
      return redirect(302, "/login")
    }

    error(400, "Error fetching profile, please try again later.")
  }
}

export const actions = {

	newtoilet: async function ({ cookies, request }) {

		const data = await request.formData()

    const title = data.get("title")
    const building = data.get("building")
    const place = data.get("place")
    const description = data.get("description")

    const valid = schemas.toilet.safeParse({ title, building, place, description })
    if (!valid.success) {
      const error = `Invalid ${valid.error.issues[0].path[0]}`
      return fail(400, { error })
    }

    const headers = { Cookie: `_session=${cookies.get("_session")}` }

		try {

      await axios.post(
        `${API_URL}/api/toilets/create`,
        { title, building, place, description },
        { headers }
      )

    } catch (e) {
      return fail(400, { error: "Error creating toilet" })
    }

		return redirect(302, "/toilets")
	}
}
