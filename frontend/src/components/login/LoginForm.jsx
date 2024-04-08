import { useForm } from "react-hook-form"
import { useNavigate } from "react-router-dom"

import loginService from "@/services/login"
import { LoginUserSchema } from "@/validations/user"
import { zodResolver } from "@hookform/resolvers/zod"
import { Button } from "@/components/ui/button"
import { Form, FormControl, FormDescription, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { toast } from "@/components/ui/use-toast"

const LoginForm = () => {

  const navigate = useNavigate()

  const form = useForm({
    resolver: zodResolver(LoginUserSchema),
    defaultValues: {
      username: "",
      password: ""
    }
  })

  const onSubmit = async (data) => {

    try {
      await loginService.login(data.username, data.password)
      toast({
        title: "Login successful"
      })
      navigate("/profile", { replace: true })
    }
    catch(e) {
      toast({
        title: "Login failed",
        description: e?.response?.data?.message || "Something went wrong"
      })
    }
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">

        <FormField
          control={form.control}
          name="username"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Username</FormLabel>
              <FormControl>
                <Input placeholder="Username" {...field} />
              </FormControl>
              <FormDescription>
                Your username is your unique identifier.
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="password"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Password</FormLabel>
              <FormControl>
                <Input placeholder="Password" {...field} type="password" />
              </FormControl>
              <FormDescription>
                Your access password, keep it safe.
              </FormDescription>
              <FormMessage />
            </FormItem>
          )}
        />

        <Button type="submit">Login</Button>
      </form>
    </Form>
  )
}

export default LoginForm
