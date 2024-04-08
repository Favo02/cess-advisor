import axios from "axios"

const baseUrl = "/api/users"

const getMe = async () =>
  (await axios.get(`${baseUrl}/me`)).data

const create = async (username, password) =>
  (await axios.post(`${baseUrl}/create`, { username, password })).data

export default {
  getMe,
  create
}
