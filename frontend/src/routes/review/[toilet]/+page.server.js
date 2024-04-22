import axios from "axios"
import { API_URL } from "$env/static/private"
import { fail, redirect } from "@sveltejs/kit"
import schemas from "../../../utils/schemas"

export const load = ({ params }) => {
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
