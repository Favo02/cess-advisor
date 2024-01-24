import axios from "axios"

const baseUrl = "/api/login"

const login = async (username, password) =>
  (await axios.post(`${baseUrl}`, { username, password })).data

const verify = async () =>
  (await axios.get(`${baseUrl}/verify`)).data

const logout = async () =>
  (await axios.post("/api/logout")).data

export default {
  login,
  verify,
  logout
}
