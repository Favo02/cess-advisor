import { useParams, useLocation, useNavigate } from "react-router-dom"
import { useForm } from "react-hook-form"

import reviewsService from "@/services/reviews"
import { CreateReviewSchema } from "@/validations/review"
import { zodResolver } from "@hookform/resolvers/zod"
import { Button } from "@/components/ui/button"
import { Form, FormControl, FormDescription, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { toast } from "@/components/ui/use-toast"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import Rating from "@mui/material/Rating"
import { styled } from "@mui/material/styles"
import { Textarea } from "@/components/ui/textarea"

const StyledRating = styled(Rating)({
  "& .MuiRating-iconFilled": { color: "#34dfa1" },
  "& .MuiRating-iconHover": { color: "#34dfa1" }
})

const ReviewPage = () => {
  const { id } = useParams()
  const location = useLocation()
  const navigate = useNavigate()

  const form = useForm({
    resolver: zodResolver(CreateReviewSchema),
    defaultValues: {
      rating: 0,
      description: ""
    }
  })

  const onSubmit = async (data) => {

    try {
      await reviewsService.create(id, data.rating*2, data.description)
      toast({
        title: "Review created successfully"
      })
      navigate("/home", { replace: true })
    }
    catch(e) {
      toast({
        title: "Creation failed",
        description: e?.response?.data?.message || "Something went wrong"
      })
    }

  }

  return (
    <Card className="w-[600px] mx-auto">

      <CardHeader>
        <CardTitle>Review {location.state.toilet.name}</CardTitle>
        <CardDescription>
          Review toilet at {location.state.toilet.place}, {location.state.toilet.floor} floor.
        </CardDescription>
      </CardHeader>

      <CardContent>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">

            <FormField
              control={form.control}
              name="description"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Review</FormLabel>
                  <FormControl>
                    <Textarea placeholder="Clean and comfortable." {...field} />
                  </FormControl>
                  <FormDescription>
                    Review description.
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="rating"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Rating</FormLabel>
                  <FormControl>
                    <div>
                      <StyledRating name="half-rating" defaultValue={2.5} precision={0.5}
                        onChange={(_, newValue) => {
                          field.onChange(newValue)
                        }}
                        value={field.value}
                      />
                    </div>
                  </FormControl>
                  <FormDescription>
                    Rating from 0 to 5. Half points are allowed.
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />

            <Button type="submit">Review</Button>
          </form>
        </Form>
      </CardContent>
    </Card>
  )

}

export default ReviewPage
