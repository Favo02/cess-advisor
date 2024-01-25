import { Toaster } from "@/components/ui/toaster"

const Wrapper = ({ children }) => (
  <>
    <Toaster />
    {children}
  </>
)

export default Wrapper
