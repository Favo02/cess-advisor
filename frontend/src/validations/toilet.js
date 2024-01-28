import { z } from "zod"
import regex from "./regex"

const CreateToiletSchema = z.object({
  name: z.string().regex(regex.genericName, { message: regex.genericNameDesc }),
  place: z.string().regex(regex.genericDescription, { message: regex.genericDescriptionDesc }),
  floor: z.number().int().min(-5).max(100)
})

export {
  CreateToiletSchema
}
