import axios from "axios"
import { API_URL } from "$env/static/private"
import { fail, redirect, error } from "@sveltejs/kit"
import schemas from "../../../utils/schemas"

export async function load({ params, cookies }) {

  const headers = { Cookie: `_session=${cookies.get("_session")}` }

  try {
    await axios.get(`${API_URL}/api/login/verify`, { headers })
    return { toilet: params.toilet }

  } catch (e) {
    if (e?.response?.status === 401) {
      return redirect(302, "/login")
    }

    console.log(e)
    error(400, "Error fetching profile, please try again later.")
  }
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

		try {

      await axios.post(
        `${API_URL}/api/reviews/create`,
        { toilet, rating, description, paper, soap, dryer, hotwater, clean, temperature },
        { headers }
      )

    } catch (e) {
      return fail(400, { error: "Error creating review" })
    }

		return redirect(302, `/reviews?q=${toilet}`)
	}
}
