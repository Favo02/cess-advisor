import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle
} from "@/components/ui/card"
import Rating from "@mui/material/Rating"
import { Button } from "../ui/button"
import { styled } from "@mui/material/styles"
import { useNavigate } from "react-router-dom"

const StyledRating = styled(Rating)({
  "& .MuiRating-iconFilled": { color: "#34dfa1" },
  "& .MuiRating-iconHover": { color: "#34dfa1" }
})

const ToiletCard = ({ toilet }) => {
  const navigate = useNavigate()

  return (
    <Card className="w-[350px]">
      <CardHeader>
        <CardTitle>{toilet.name || <i>No name</i>}</CardTitle>
        <CardDescription>{toilet.place || <i>No place</i>}, {toilet.floor} floor</CardDescription>
      </CardHeader>
      <CardContent>
        {toilet.rating
          ? <>
            <StyledRating name="half-rating-read" defaultValue={toilet.rating/2} precision={0.5} readOnly />
            <p className="text-center">{toilet.reviews_count} reviews: <b>{toilet.rating/2}</b> average</p>
          </>
          : <>
            <StyledRating name="half-rating-read" defaultValue={0} precision={0.5} readOnly disabled />
            <p className="text-center">No reviews yet</p>
          </>
        }
      </CardContent>
      <CardFooter className="flex justify-between">
        <CardDescription className="text-xs"><i>Added by {toilet.creator_name}</i></CardDescription>
        <Button onClick={
          () => navigate(`/toilets/${toilet.id}/review`, { state: { toilet: toilet } })
        }>Review</Button>
      </CardFooter>
    </Card>
  )
}

export default ToiletCard
