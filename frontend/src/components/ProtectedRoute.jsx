import { useState, useEffect } from "react"
import { Navigate } from "react-router-dom"
import loginService from "@/services/login"

const ProtectedRoute = ({ children }) => {

  const [auth, setAuth] = useState(false)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    const authenticate = async () => {
      try {
        await loginService.verify()
        setAuth(true)
      }
      catch (err) {
        setAuth(false)
      }
      finally {
        setIsLoading(false)
      }
    }

    authenticate()
  }, [])

  if (!auth && !isLoading) {
    localStorage.removeItem("expires")
    localStorage.removeItem("token")
    return <Navigate to="/login" replace />
  }

  if (isLoading) {
    return <p>loading...</p>
  }

  return (
    <>
      {isLoading && <p> loading... </p>}
      {children}
    </>
  )
}

export default ProtectedRoute
