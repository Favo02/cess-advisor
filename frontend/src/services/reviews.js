import axios from "axios"

const baseUrl = "/api/reviews"

const create = async (toilet, rating, description ) =>
  (await axios.post(`${baseUrl}/create`, { toilet, rating, description })).data

export default {
  create
}
