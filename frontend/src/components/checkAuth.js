import axios from "axios"

async function checkAuth() {
  try {
    const response = await axios.get(
      `${import.meta.env.VITE_API_URL}/api/login/verify`,
      { withCredentials: true }
    )
    if (response.status === 200) {
      return true
    } else {
      return false
    }
  } catch (error) {
    return false
  }
}

export default checkAuth
