import usersService from "@/services/users"
import loginService from "@/services/login"
import { useEffect } from "react"
import { toast } from "@/components/ui/use-toast"
import { useState } from "react"
import { useNavigate } from "react-router-dom"
import { Button } from "@/components/ui/button"

const ProfilePage = () => {

  const navigate = useNavigate()
  const [me, setMe] = useState(null)

  useEffect (() => {

    const fetchProfile = async () => {
      try {
        const data = await usersService.getMe()
        setMe(data)
      }
      catch(e) {
        toast({
          title: "Error fetching profile",
          description: e?.response?.data?.message || "Something went wrong"
        })
      }
    }

    fetchProfile()
  }, [])

  const logoutHandler = async () => {

    try {
      await loginService.logout()
      toast({
        title: "Logout successful"
      })
      navigate("/login", { replace: true })
    }
    catch(e) {
      toast({
        title: "Logout failed",
        description: e?.response?.data?.message || "Something went wrong"
      })
    }
  }

  if (!me) {
    return <div>Loading...</div>
  }

  return (
    <div>
      <h1>Profile</h1>
      {JSON.stringify(me)}

      <br />
      <Button onClick={logoutHandler}>Logout</Button>
    </div>
  )
}

export default ProfilePage
