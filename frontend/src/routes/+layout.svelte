<script>
  import "../app.pcss"
  import Header from "../components/header.svelte"
  import Footer from "../components/footer.svelte"
  import { page } from "$app/stores"
  import { Toaster } from "svelte-french-toast"
  import { onMount, afterUpdate } from "svelte"

  let route = ""

  onMount(pageLoad)
  afterUpdate(pageLoad)

  function pageLoad() {
    route = $page.url.pathname
  }
</script>

<Header {route} />

<Toaster />

<div class="">
  <slot />
</div>

<Footer {route} />
