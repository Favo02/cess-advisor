import { API_URL } from "$env/static/private"
import { fail, redirect, error } from "@sveltejs/kit"
import schemas from "../../../utils/schemas"
import f from "../../../utils/customFetch"

export async function load({ params, cookies }) {

  const headers = { Cookie: `_session=${cookies.get("_session")}` }
  const data = await f.get(`${API_URL}/api/login/verify`, headers)

  if (!data.ok) {
    if (data.status === 401) {
      return redirect(302, "/login") // TODO: notification, redirect
    }

    return error(500, "Error fetching user, please try again later.")
  }

  return { toilet: params.toilet }
}

export const actions = {

	review: async function ({ cookies, request }) {

		const data = await request.formData()

    const toilet = data.get("toilet")
    const rating = parseInt(data.get("rating"))
    const description = data.get("description")
    const paper = !!data.get("paper")
    const soap = !!data.get("soap")
    const dryer = !!data.get("dryer")
    const hotwater = !!data.get("hotwater")
    const clean = parseInt(data.get("clean"))
    const temperature = parseInt(data.get("temperature"))

    const valid = schemas.review.safeParse({ toilet, rating, description, paper, soap, dryer, hotwater, clean, temperature })
    if (!valid.success) {
      const error = `Invalid ${valid.error.issues[0].path[0]}`
      return fail(400, { error })
    }

    const headers = { Cookie: `_session=${cookies.get("_session")}` }
    const response = await f.post(
      `${API_URL}/api/reviews/create`,
      headers,
      { toilet, rating, description, paper, soap, dryer, hotwater, clean, temperature }
    )

    if (!response.ok) {
      if (data.status === 401) {
        return redirect(302, "/login") // TODO: notification, redirect
      }
      if (response.status === 400) {
        return fail(400, { error: "Error creating review" })
      }

      return error(500, "Error creating review.")
    }


		return redirect(302, `/reviews?q=${toilet}`) // TODO: notification
  }
}
