import axios from "axios"
import { API_URL } from '$env/static/private';
import { error } from "@sveltejs/kit"

export async function load() {

  try {
    const response = await axios.get(`${API_URL}/api/toilets`)
    return { toilets: response.data }

  } catch (e) {
    error(400, "Error fetching toilets, please try again later.")
  }

}
