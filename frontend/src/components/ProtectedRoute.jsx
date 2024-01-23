import { useState, useEffect } from "react"
import { Navigate } from "react-router-dom"

const ProtectedRoute = ({ children }) => {

  const [auth, setAuth] = useState(false)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    const authenticate = async () => {
      setAuth(false)
      setIsLoading(false)

      // try {
      //   await loginService.verify()
      //   setAuth(true)
      // }
      // catch (err) {
      //   setAuth(false)
      // }
      // finally {
      //   setIsLoading(false)
      // }
    }

    authenticate()
  }, [])

  if (!auth && !isLoading) {
    localStorage.removeItem("expires")
    localStorage.removeItem("token")
    return <Navigate to="/login" replace />
  }

  return (
    <>
      {isLoading && <p> loading... </p>}
      {children}
    </>
  )
}

export default ProtectedRoute
