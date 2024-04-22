import { env } from "$env/dynamic/private"
import { error } from "@sveltejs/kit"
import f from "../utils/customFetch"

export async function load() {

  const data = await f.get(`${env.API_URL}/api/stats`, {})

  if (!data.ok) {
    return error(500, "Error fetching homepage, please try again later.")
  }

  return { stats: data.json }
}
