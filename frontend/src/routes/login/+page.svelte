<svelte:head>
  <title>CessAdvisor - Login</title>
</svelte:head>

<script>
  import Icon from "@iconify/svelte"
  import toast from "svelte-french-toast"
  import schemas from "../../utils/schemas"
  import { onMount } from "svelte"
  import { page } from "$app/stores"

  export let form

  let username = ""
  let password = ""
  let to = ""

  function clientVerification(event) {
    const valid = schemas.login.safeParse({ username, password })
    if (!valid.success) {
      const error = `Invalid ${valid.error.issues[0].path[0]}`
      toast.error(error)
      return
    }
    event.target.submit()
  }

  if (form?.error) {
    toast.error(form.error)
  }

  onMount(() => {
    to = $page.url.searchParams.get("to")
  })
</script>

<div class="w-full py-28 bg-base-300">
  <h1 class="mx-auto text-4xl text-center mb-3 font-bold">Welcome, please <span class="text-primary">login</span></h1>
  <p class="mx-auto text-lg text-center mb-10 italic">Don't have an account? <a href="/register" class="text-primary link">Register</a>.</p>

  <form class="max-w-sm mx-auto" method="POST" action="?/login" on:submit|preventDefault={(event) => clientVerification(event)}>

    <input type="hidden" name="to" bind:value={to}>

    <div class="pb-6">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Username</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="clarity:user-solid" class="w-5 h-5" />
        </div>
        <input type="text" name="username" bind:value={username} class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="User">
      </div>
    </div>

    <div class="pb-8">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Password</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="tabler:key-filled" class="w-5 h-5" />
        </div>
        <input type="password" name="password" bind:value={password} class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="P4s$w0rd">
      </div>
    </div>

    <button class="btn btn-primary mx-auto w-full mb-8" type="submit">
      <Icon icon="carbon:login" class="w-6 h-6" />
      Login
    </button>
    <div class="flex">
      <a href={(to !== "") ? `/register?to=${to}` : "/register"} class="btn btn-primary btn-outline mx-auto w-[calc(50%-8px)] mr-2 mb-8">
        <Icon icon="mdi:register" class="w-6 h-6" />
        Register
      </a>
      <a href="/" class="btn btn-primary btn-outline mx-auto w-[calc(50%-8px)] ml-2">
        <Icon icon="pajamas:go-back" class="w-6 h-6" />
        Homepage
      </a>
    </div>

  </form>
</div>
