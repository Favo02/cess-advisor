import { useForm } from "react-hook-form"
import { useNavigate } from "react-router-dom"

import toiletsService from "@/services/toilets"
import { CreateToiletSchema } from "@/validations/toilet"
import { zodResolver } from "@hookform/resolvers/zod"
import { Button } from "@/components/ui/button"
import { Form, FormControl, FormDescription, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { toast } from "@/components/ui/use-toast"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"

const NewToiletPage = () => {

  const navigate = useNavigate()

  const form = useForm({
    resolver: zodResolver(CreateToiletSchema),
    defaultValues: {
      name: "",
      place: "",
      floor: 0
    }
  })

  const onSubmit = async (data) => {

    try {
      await toiletsService.create(data.name, data.place, data.floor)
      toast({
        title: "Toilet created successfully"
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
        <CardTitle>New toilet</CardTitle>
        <CardDescription>
          Register a new toilet.
        </CardDescription>
      </CardHeader>

      <CardContent>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">

            <FormField
              control={form.control}
              name="name"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Name</FormLabel>
                  <FormControl>
                    <Input placeholder="Chemisty laboratory toilet" {...field} />
                  </FormControl>
                  <FormDescription>
                    Name of the toilet.
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="place"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Place</FormLabel>
                  <FormControl>
                    <Input placeholder="Building 42, Department of CS" {...field} />
                  </FormControl>
                  <FormDescription>
                    Place of the bathroom, short description (preferably building or address).
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="floor"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Floor</FormLabel>
                  <FormControl>
                    <Input {...field} type="number" onChange={event => field.onChange(+event.target.value)} />
                  </FormControl>
                  <FormDescription>
                    Floor the bathroom is located on. Ground floor is 0, not 1.
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />

            <Button type="submit">Create</Button>
          </form>
        </Form>
      </CardContent>
    </Card>
  )
}

export default NewToiletPage
