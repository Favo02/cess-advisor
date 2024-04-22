import { API_URL } from "$env/static/private"
import { error } from "@sveltejs/kit"
import f from "../../utils/customFetch"

export async function load() {

  const data = await f.get(`${API_URL}/api/toilets`, {})

  if (!data.ok) {
    return error(500, "Error fetching toilets, please try again later.")
  }

  return { toilets: data.json }
}
