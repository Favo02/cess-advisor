import { useState, useEffect } from "react"
import { Navigate } from "react-router-dom"

import loginService from "@/services/login"
import { toast } from "@/components/ui/use-toast"

const Authorization = ({ children }) => {

  const [auth, setAuth] = useState(false)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    const authenticate = async () => {
      try {
        await loginService.verify()
        setAuth(true)
      }
      catch (e) {
        toast({
          title: "Not authorized",
          description: e?.response?.data?.message || "Something went wrong"
        })
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

export default Authorization
