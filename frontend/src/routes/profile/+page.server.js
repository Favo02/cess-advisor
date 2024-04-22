import axios from "axios"
import { API_URL } from '$env/static/private';
import { error, redirect, fail } from "@sveltejs/kit"
import f from "../../utils/customFetch";

export async function load({ cookies }) {

  const headers = { Cookie: `_session=${cookies.get("_session")}` }
  const data = await f.get(`${API_URL}/api/users/me`, headers)

  if (!data.ok) {
    if (data.status === 401) {
      return redirect(302, "/login") // TODO: notification, redirect
    }

    return error(500, "Error fetching profile, please try again later.")
  }

  return { profile: data.json }
}

export const actions = {

	logout: async function ({ cookies }) {

    const headers = { Cookie: `_session=${cookies.get("_session")}` }

		try {

      const response = await axios.post(
        `${API_URL}/api/logout`,
        {},
        { headers }
      )

      if (response.status === 200) {
        cookies.set("_session", "", {
          path: "/",
          sameSite: "Strict",
          maxAge: -1,
          secure: true,
          httpOnly: true
        })
      } else {
        return fail(400, { error: "Error logging out" })
      }

    } catch (e) {
      return fail(400, { error: "Error logging out" })
    }

		return redirect(302, "/")
	}
}
