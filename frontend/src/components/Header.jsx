import logo from "@/assets/logo.png"
import { useNavigate } from "react-router-dom"
import { Button } from "@/components/ui/button"
import { useEffect, useState } from "react"
import Cookies from "js-cookie"


const Header = () => {
  const navigate = useNavigate()
  const [user, setUser] = useState(null)

  useEffect(() => {
    const session = Cookies.get("_session")?.match(/"id":"(.*?)"/)
    console.log(session)

    if (session) {
      setUser(session[1])
    }

  }, [])

  return (
    <div className="mx-10 flex items-center justify-between my-6 p-3 px-10 border-y-2 border-customgreen/30 rounded-3xl bg-gradient-to-r from-white via-customgreen/10 to-white">

      <div onClick={() => navigate("/home")} className="flex items-center cursor-pointer">
        <img src={logo} alt="Logo" className="h-16 w-auto mx-6" />
        <h1 className="font-bold tracking-tight text-3xl">Cessadvisor</h1>
      </div>

      {user
        ?
        <div>
          <Button className="rounded-lg" onClick={() => navigate("/profile")}>Profile</Button>
        </div>
        :
        <div>
          <Button className="rounded-lg" onClick={() => navigate("/login")}>Login</Button>
        </div>
      }
    </div>
  )
}

export default Header
