import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import LoginForm from "./LoginForm"
import RegisterForm from "./RegisterForm"
import { useEffect } from "react"
import loginService from "@/services/login"
import { useNavigate } from "react-router-dom"

// TODO: refactor using the same component for both login and register

const LoginPage = () => {

  const navigate = useNavigate()

  // kick out of login/register page if already logged in
  useEffect(() => {
    const authenticate = async () => {
      try {
        await loginService.verify()
        navigate("/profile", { replace: true })
      }
      catch (err) {
        // do nothing
      }
    }

    authenticate()
  }, [navigate])


  return (
    <div className="flex flex-col items-center justify-center w-full h-full">
      <div className="w-1/3 min-w-[400px] mx-auto min-h-[100vh] flex flex-col items-center justify-center">

        <Tabs defaultValue="login" className="w-[400px]">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="login">Login</TabsTrigger>
            <TabsTrigger value="register">Register</TabsTrigger>
          </TabsList>

          <TabsContent value="login">
            <Card>

              <CardHeader>
                <CardTitle>Login</CardTitle>
                <CardDescription>
                  Access your existing account.
                </CardDescription>
              </CardHeader>

              <CardContent className="space-y-2">
                <LoginForm />
              </CardContent>

            </Card>
          </TabsContent>

          <TabsContent value="register">
            <Card>
              <CardHeader>
                <CardTitle>Register</CardTitle>
                <CardDescription>
                  Create a new account.
                </CardDescription>
              </CardHeader>

              <CardContent className="space-y-2">
                <RegisterForm />
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
}

export default LoginPage
