import { API_URL } from "$env/static/private"
import { error, redirect } from "@sveltejs/kit"
import f from "../../utils/customFetch"

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
    const response = await f.post(
      `${API_URL}/api/logout`,
      headers,
      {}
    )

    if (!response.ok) {
      return error(500, "Error logging out, please try again later.")
    }

    cookies.set("_session", "", {
      path: "/",
      sameSite: "Strict",
      maxAge: -1,
      secure: true,
      httpOnly: true
    })

		return redirect(302, "/") // TODO: notification
  }
}
