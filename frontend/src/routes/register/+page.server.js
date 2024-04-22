import axios from "axios"
import { API_URL } from "$env/static/private"
import { fail, redirect, error } from "@sveltejs/kit"
import schemas from "../../utils/schemas"

export async function load({ cookies }) {

  const headers = { Cookie: `_session=${cookies.get("_session")}` }

  try {
    await axios.get(`${API_URL}/api/login/verify`, { headers })
    return redirect(302, "/profile")

  } catch (e) {
    if (e?.response?.status === 200 || e?.status === 302) {
      return redirect(302, "/profile")
    }
    if (e?.response?.status !== 401) {
      return error(400, "Error fetching profile, please try again later.")
    }

    return { login: false }
  }
}

export const actions = {

	register: async function ({ cookies, request }) {

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
        `${API_URL}/api/users/create`,
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
      if (e.response.data.message === "username already taken") {
        return fail(400, { error: "Username already taken" })
      }
      return fail(400, { error: "Error creating user" })
    }

		return redirect(302, "/profile")
	}
}
