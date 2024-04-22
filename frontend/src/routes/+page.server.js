import axios from "axios"
import { API_URL } from '$env/static/private';
import { error } from "@sveltejs/kit"

export async function load() {

  try {
    const response = await axios.get(`${API_URL}/api/stats`)
    return { stats: response.data }

  } catch (e) {
    error(400, "Error fetching homepage, please try again later.")
  }

}
