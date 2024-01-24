import { z } from "zod"
import regex from "./regex"

const LoginUserSchema = z.object({
  username: z.string().regex(regex.username, { message: regex.usernameDesc }),
  password: z.string().regex(regex.password, { message: regex.passwordDesc })
})

const CreateUserSchema = z.object({
  username: z.string().regex(regex.username, { message: regex.usernameDesc }),
  password: z.string().regex(regex.password, { message: regex.passwordDesc }),
  confirmPassword: z.string().regex(regex.password, { message: regex.passwordDesc })
})

export {
  LoginUserSchema,
  CreateUserSchema
}
