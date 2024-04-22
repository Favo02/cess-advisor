import axios from "axios"
import { API_URL } from "$env/static/private"
import { fail, redirect } from "@sveltejs/kit"
import schemas from "../../utils/schemas"

export const actions = {

	login: async function ({ cookies, request }) {

		const data = await request.formData()

		const username = data.get("username")
		const password = data.get("password")

    const valid = schemas.login.safeParse({ username, password })
    if (!valid.success) {
      const error = `Invalid ${valid.error.issues[0].path[0]}`
      return fail(400, { error })
    }

    const headers = { Cookie: `_session=${cookies.get("_session")}` }

		try {

      const response = await axios.post(
        `${API_URL}/api/login`,
        { username, password },
        { headers }
      )

      // FIXME: really really awful, but it works
      const cookieString = response.headers["set-cookie"][0]
      const cookie = cookieString.substring(cookieString.indexOf("=")+1).split(";")[0]

      cookies.set("_session", cookie, {
        path: "/",
        sameSite: "Strict",
        maxAge: 60 * 60 * 24,
        secure: true,
        httpOnly: true
      })

    } catch (e) {
      return fail(400, { error: "Invalid username or password" })
    }

		return redirect(302, "/profile")
	}
}
