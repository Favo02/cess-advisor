<script>
  import axios from "axios"
  import Icon from "@iconify/svelte"
  import checkAuth from "../../utils/checkAuth"
  import { onMount } from "svelte"
  import toast from "svelte-french-toast"

  let username = ""
  let password = ""
  let confirmPassword = ""

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

    if (password !== confirmPassword) {
      toast.error("Passwords do not match")
      loading = false
      return
    }

    try {
      const response = await axios.post(
        `${import.meta.env.VITE_API_URL}/api/users/create`,
        { username, password },
        { withCredentials: true }
      )

      if (response.status === 201) {
        toast.success("User created successfully")
        window.location.href = "/profile"
      } else {
        toast.error("Error creating user")
      }

    } catch (error) {
      toast.error("Error creating user")
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
  <h1 class="mx-auto text-4xl text-center mb-3 font-bold">A new user? Wow, <span class="text-primary">register</span></h1>
  <p class="mx-auto text-lg text-center mb-10 italic">Already have an account? <a href="/login" class="text-primary link">Login</a>.</p>

  <form class="max-w-sm mx-auto">

    <div class="pb-6">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Username</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="clarity:user-solid" class="w-5 h-5" />
        </div>
        <input type="text" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="User" bind:value={username}>
      </div>
    </div>

    <div class="pb-6">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Password</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="tabler:key-filled" class="w-5 h-5" />
        </div>
        <input type="password" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="P4s$w0rd" bind:value={password}>
      </div>
    </div>

    <div class="pb-8">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Confirm password</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="tabler:key-filled" class="w-5 h-5" />
        </div>
        <input type="password" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="P4s$w0rd" bind:value={confirmPassword}>
      </div>
    </div>

    <button class="btn btn-primary mx-auto w-full mb-8" on:click={handleSubmit}>
      {#if loading}
        <Icon icon="line-md:loading-loop" class="w-6 h-6" />
      {:else}
        <Icon icon="mdi:register" class="w-6 h-6" />
      {/if}
      Register
    </button>
    <div class="flex">
      <a href="/login" class="btn btn-primary btn-outline mx-auto w-[calc(50%-8px)] mr-2 mb-8">
        <Icon icon="carbon:login" class="w-6 h-6" />
        Login
      </a>
      <a href="/" class="btn btn-primary btn-outline mx-auto w-[calc(50%-8px)] ml-2">
        <Icon icon="pajamas:go-back" class="w-6 h-6" />
        Homepage
      </a>
    </div>

  </form>

</div>

