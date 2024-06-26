import { z } from "zod"
import regex from "./regex"

const login = z.object({
  username: z.string().regex(regex.username),
  password: z.string().regex(regex.password),
})

const review = z.object({
  toilet: z.string().uuid(),
  rating: z.number().multipleOf(0.5).min(0).max(5),
  description: z.string().regex(regex.genericLongText),
  paper: z.boolean(),
  soap: z.boolean(),
  dryer: z.boolean(),
  hotwater: z.boolean(),
  clean: z.number().multipleOf(0.5).min(0).max(5),
  temperature: z.number().multipleOf(0.5).min(0).max(5),
})

const toilet = z.object({
  title: z.string().regex(regex.genericShortText),
  university: z.string().regex(regex.genericShortText),
  building: z.string().regex(regex.genericShortText),
  place: z.string().regex(regex.genericShortText),
  description: z.string().regex(regex.genericLongText),
})

export default {
  login,
  review,
  toilet,
}
