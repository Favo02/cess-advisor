import { Toaster } from "@/components/ui/toaster"
import Header from "@/components/Header"

const Wrapper = ({ children }) => (
  <div className="max-w-[1200px] mx-auto text-center">
    <Header />
    <Toaster />
    {children}
  </div>
)

export default Wrapper
