<svelte:head>
  <title>CessAdvisor - Not found</title>
</svelte:head>

<script>
	import { page } from "$app/stores"

  let status = $page.status ?? 404
  let title = status == 404 ? "not found" : "server error"
  let message = status == 404 ? "Page not found, please go back to home." : $page.error.message
</script>


<div class="w-full pt-40 bg-base-300 min-h-[calc(100vh-15rem)] flex justify-center align-middle flex-col">
  <h1 class="mx-auto text-4xl text-center mb-3 font-bold">We're sorry, <span class="text-primary">{title}</span></h1>
  <p class="mx-auto text-lg text-center mb-10 italic">{status} - {message}</p>
</div>
