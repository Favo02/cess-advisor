import { env } from "$env/dynamic/private"
import { error } from "@sveltejs/kit"
import f from "../utils/customFetch"

export async function load() {

  const stats = await f.get(`${env.API_URL}/api/stats`, {})

  if (!stats.ok) {
    return error(500, "Error fetching homepage, please try again later.")
  }

  const issues = await f.get(`https://api.github.com/repos/Favo02/cess-advisor/issues`, {})

  if (!issues.ok) {
    issues.json = []
  }

  return { stats: stats.json, issues: issues.json }
}
