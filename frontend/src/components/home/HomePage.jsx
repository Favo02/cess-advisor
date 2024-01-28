import toiletsService from "@/services/toilets"
import { useEffect, useState } from "react"
import ToiletCard from "@/components/home/ToiletCard"
import { Button } from "../ui/button"
import { useNavigate } from "react-router-dom"

const HomePage = () => {

  const navigate = useNavigate()
  const [toilets, setToilets] = useState([])

  useEffect(() => {
    const fetchToilets = async () => {
      const toilets = await toiletsService.getAll()
      setToilets(toilets)
    }

    fetchToilets()
  }, [])

  return (
    <div className="text-center m-4">

      <div className="mx-auto w-[1000px] flex border-b pb-2">

        <div className="w-[90%]">
          <h2 className=" scroll-m-20 text-3xl font-bold tracking-wide first:mt-0">
            Available Toilets
          </h2>
          <h4 className="italic scroll-m-20 text-lg font-medium tracking-tight">
            Someone added and reviewed these toilets, you can do it too!
          </h4>
        </div>

        <Button className="mx-auto mt-4" onClick={() => navigate("/toilets/new")}>
          Add a new toilet
        </Button>

      </div>

      <div className="mx-auto w-[95%] flex flex-wrap gap-4 mt-10 justify-center">
        {toilets.map(toilet => <ToiletCard key={toilet.id} toilet={toilet} /> )}
      </div>

    </div>
  )
}

export default HomePage
