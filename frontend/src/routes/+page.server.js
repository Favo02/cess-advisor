import { API_URL } from "$env/static/private"
import { error } from "@sveltejs/kit"
import f from "../utils/customFetch"

export async function load() {

  const data = await f.get(`${API_URL}/api/stats`, {})

  if (!data.ok) {
    return error(500, "Error fetching homepage, please try again later.")
  }

  return { stats: data.json }
}
