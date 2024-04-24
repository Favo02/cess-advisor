<script>
  import "../app.pcss"
  import Header from "../components/header.svelte"
  import Footer from "../components/footer.svelte"
  import { page } from "$app/stores"
  import toast, { Toaster } from "svelte-french-toast"
  import { onMount, afterUpdate } from "svelte"
  import { replaceState } from "$app/navigation"
  import codes from "../utils/redirectCodes"

  let route = ""

  onMount(pageLoad)
  afterUpdate(pageLoad)

  function pageLoad() {
    route = $page.url.pathname

    let redirectStatus = $page.url.searchParams.get("r")
    if (redirectStatus) {
      if (codes[redirectStatus].isError) {
        toast.error(codes[redirectStatus].msg)
      } else {
        toast.success(codes[redirectStatus].msg)
      }
    }

    // TODO: bad workaround to avoid "double" redirection issues
    setTimeout(() => {
      if (redirectStatus) {
        $page.url.searchParams.delete("r")
        if ($page.url.searchParams.toString() === "") {
          replaceState(route)
        } else {
          replaceState(`${route}?${$page.url.searchParams.toString()}`)
        }
      }
    }, 100);
  }
</script>

<Header {route} />

<Toaster />

<div class="">
  <slot />
</div>

<Footer {route} />
