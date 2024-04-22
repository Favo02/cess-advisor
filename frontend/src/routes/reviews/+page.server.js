import axios from "axios"
import { API_URL } from '$env/static/private';
import { error } from "@sveltejs/kit"

export async function load() {

  try {
    const response = await axios.get(`${API_URL}/api/reviews`)
    return { reviews: response.data }

  } catch (e) {
    console.log(e)
    error(400, "Error fetching reviews, please try again later.")
  }

}
