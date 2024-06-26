import { env } from "$env/dynamic/private"
import { fail, redirect, error } from "@sveltejs/kit"
import schemas from "../../utils/schemas"
import f from "../../utils/customFetch"

export async function load({ cookies }) {

  const headers = { Cookie: `_session=${cookies.get("_session")}` }
  const data = await f.get(`${env.API_URL}/api/login/verify`, headers)

  if (data.ok) {
    return redirect(302, "/profile?r=402")
  }
  if (!data.ok && data.status !== 401) {
    return error(500, "Error fetching user, please try again later.")
  }

  return { login: false }
}

export const actions = {

	login: async function ({ cookies, request }) {

		const data = await request.formData()

		const username = data.get("username")
		const password = data.get("password")
    const to = data.get("to") || "/profile"

    const valid = schemas.login.safeParse({ username, password })
    if (!valid.success) {
      const error = `Invalid ${valid.error.issues[0].path[0]}`
      return fail(400, { error })
    }

    const headers = { Cookie: `_session=${cookies.get("_session")}` }
    const response = await f.post(
      `${env.API_URL}/api/login`,
      headers,
      { username, password }
    )

    if (!response.ok) {
      if ((response.status === 400) || (response.status === 401)) {
        return fail(400, { error: "Invalid username or password" })
      }

      return error(500, "Error logging in, please try again later.")
    }

    // TODO: fix this awful shit (but it works)
    const cookieString = response.headers.get("set-cookie")
    const cookie = cookieString.substring(cookieString.indexOf("=")+1).split(";")[0]

    cookies.set("_session", cookie, {
      path: "/",
      sameSite: "Strict",
      maxAge: 60 * 60 * 24,
      secure: true,
      httpOnly: true
    })

		return redirect(302, `${to}?r=201`)
	}
}
