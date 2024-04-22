<script>
  import axios from "axios"
  import checkAuth from "../../utils/checkAuth"
  import Icon from "@iconify/svelte"
  import { onMount } from "svelte"
  import toast from "svelte-french-toast"
  import schemas from "../../utils/schemas"

  let username = ""
  let password = ""

  let loading = true

  onMount(async () => {
    if (await checkAuth()) {
      toast.error("You are already logged in")
      window.location.href = "/profile"
    }
    loading = false
  })

  async function handleSubmit() {
    loading = true

    const valid = schemas.login.safeParse({ username, password })
    if (!valid.success) {
      toast.error(`Invalid ${valid.error.issues[0].path[0]}`)
      loading = false
      return
    }

    try {
      const response = await axios.post(
        `${import.meta.env.VITE_API_URL}/api/login`,
        { username, password },
        { withCredentials: true }
      )

      if (response.status === 200) {
        toast.success("Logged in successfully")
        window.location.href = "/profile"
      } else {
        toast.error("Error logging in")
      }

    } catch (error) {
      toast.error("Error logging in")
    } finally {
      loading = false
    }
  }

</script>

{#if loading}
  <div class="w-full min-h-screen py-28 bg-base-300 flex justify-center align-middle">
    <span class="loading loading-spinner loading-xl"></span>
  </div>
{/if}

<div class="w-full py-28 bg-base-300">
  <h1 class="mx-auto text-4xl text-center mb-3 font-bold">Welcome, please <span class="text-primary">login</span></h1>
  <p class="mx-auto text-lg text-center mb-10 italic">Don't have an account? <a href="/register" class="text-primary link">Register</a>.</p>

  <form class="max-w-sm mx-auto">

    <h1 class="text-justify rounded-md p-8 mb-8 text-black bg-red-400 border-red-950 border-4">WARNING: the app is having some issues with CORS and cookies. If the login don't work, please enable third party cookies in your browser. Sorry for the inconvenience, working on a fix. <a target="_blank" href="https://github.com/Favo02/cess-advisor/issues/9" class="link">Issue on GitHub</a>.</h1>

    <div class="pb-6">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Username</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="clarity:user-solid" class="w-5 h-5" />
        </div>
        <input type="text" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="User" bind:value={username}>
      </div>
    </div>

    <div class="pb-8">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Password</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="tabler:key-filled" class="w-5 h-5" />
        </div>
        <input type="password" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="P4s$w0rd" bind:value={password}>
      </div>
    </div>

    <button class="btn btn-primary mx-auto w-full mb-8" on:click={handleSubmit}>
      {#if loading}
        <Icon icon="line-md:loading-loop" class="w-6 h-6" />
      {:else}
        <Icon icon="carbon:login" class="w-6 h-6" />
      {/if}
      Login
    </button>
    <div class="flex">
      <a href="/register" class="btn btn-primary btn-outline mx-auto w-[calc(50%-8px)] mr-2 mb-8">
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
