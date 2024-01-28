import { z } from "zod"
import regex from "./regex"

const CreateReviewSchema = z.object({
  description: z.string().regex(regex.genericDescription, { message: regex.genericDescriptionDesc }),
  rating: z.number().step(0.5).min(0).max(5)
})

export {
  CreateReviewSchema
}
