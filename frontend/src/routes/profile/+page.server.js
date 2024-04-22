import axios from "axios"
import { API_URL } from '$env/static/private';
import { error, redirect } from "@sveltejs/kit"

export async function load({ cookies }) {

  const headers = { Cookie: `_session=${cookies.get("_session")}` }

  try {
    const response = await axios.get(`${API_URL}/api/users/me`, { headers })
    return { profile: response.data }

  } catch (e) {
    if (e.response.status === 401) {
      return redirect(302, "/login")
    }

    error(400, "Error fetching profile, please try again later.")
  }

}
