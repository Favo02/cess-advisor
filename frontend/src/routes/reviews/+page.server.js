import { API_URL } from '$env/static/private';
import { error } from "@sveltejs/kit"
import f from "../../utils/customFetch";

export async function load() {

  const data = await f.get(`${API_URL}/api/reviews`, {})

  if (!data.ok) {
    return error(500, "Error fetching reviews, please try again later.")
  }

  return { reviews: data.json }
}
