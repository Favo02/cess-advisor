<script>
  import "../app.pcss"

  import Header from "../components/header.svelte"
  import Footer from "../components/footer.svelte"

  import {Toaster} from "svelte-french-toast"
</script>

<Header />

<Toaster />

<div class="">
  <slot />
</div>

<Footer />
