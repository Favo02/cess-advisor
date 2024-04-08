import axios from "axios"

const baseUrl = "/api/toilets"

const getAll = async () =>
  (await axios.get(`${baseUrl}`)).data

const create = async (name, place, floor) =>
  (await axios.post(`${baseUrl}/create`, { name, place, floor })).data

export default {
  getAll,
  create
}
