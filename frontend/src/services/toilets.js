import axios from "axios"
import Cookies from "js-cookie"

const baseUrl = "/api/toilets"

const getAll = async () =>
  (await axios.get(`${baseUrl}`)).data

const create = async (name, place, floor) => {
  const session = Cookies.get("_session").match(/"id":"(.*?)"/)
  const creator = session ? session[1] : null

  return (await axios.post(`${baseUrl}/create`, { name, place, floor, creator })).data
}

export default {
  getAll,
  create
}
