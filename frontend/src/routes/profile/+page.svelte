<svelte:head>
  <title>CessAdvisor - Profile</title>
</svelte:head>

<script>
  import Icon from "@iconify/svelte"
  import axios from "axios"
  import { onMount } from "svelte"
  import checkAuth from "../../utils/checkAuth"
  import toast from "svelte-french-toast"

  let promise = axios.get(
    `${import.meta.env.VITE_API_URL}/api/users/me`,
    { withCredentials: true }
  )

  let loading = true

  onMount(async () => {
    if (!(await checkAuth())) {
      toast.error("You are not logged in")
      window.location.href = "/login"
    }
    loading = false
  })

  async function handleSubmit() {
    loading = true

    try {
      const response = await axios.post(
        `${import.meta.env.VITE_API_URL}/api/logout`,
        {},
        { withCredentials: true }
      )

      if (response.status === 200) {
        toast.success("Logged out successfully")
        window.location.href = "/"
      } else {
        toast.error("Error logging out")
      }

    } catch (error) {
      toast.error("Error logging out")
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

{#await promise}
  <div class="w-full min-h-screen py-28 bg-base-300 flex justify-center align-middle">
    <span class="loading loading-spinner loading-xl"></span>
  </div>
{:then profile}
  <div class="w-full py-28 bg-base-300">
    <h1 class="mx-auto text-4xl text-center mb-3 font-bold">Hello there, your <span class="text-primary">profile</span></h1>

    <form class="max-w-sm mx-auto mt-20">

      <div class="pb-6">
        <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Username</label>
        <div class="relative peer">
          <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
            <Icon icon="clarity:user-solid" class="w-5 h-5" />
          </div>
          <input type="text" readonly class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg opacity-60 block w-full ps-10 p-2.5" placeholder="User" value={profile.data.username}>
        </div>
      </div>

      <div class="pb-6">
        <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Toilets created</label>
        <div class="relative peer">
          <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
            <Icon icon="mingcute:toilet-paper-fill" class="w-5 h-5" />
          </div>
          <input type="text" readonly class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg opacity-60 block w-full ps-10 p-2.5" placeholder="P4s$w0rd" value={profile.data.toilets_created}>
        </div>
      </div>

      <div class="pb-8">
        <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Reviews authored</label>
        <div class="relative peer">
          <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
            <Icon icon="material-symbols:reviews" class="w-5 h-5" />
          </div>
          <input type="text" readonly class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg opacity-60 block w-full ps-10 p-2.5" placeholder="P4s$w0rd" value={profile.data.reviews_authored}>
        </div>
      </div>

      <button disabled class="btn btn-primary btn-outline mx-auto w-full mb-8">
        <Icon icon="carbon:login" class="w-6 h-6" />
        Edit profile <span class="italic">(coming soon)</span>
      </button>
      <button class="btn btn-primary mx-auto w-full" on:click={handleSubmit}>
        {#if loading}
          <Icon icon="line-md:loading-loop" class="w-6 h-6" />
        {:else}
          <Icon icon="carbon:logout" class="w-6 h-6" />
        {/if}
        Logout
      </button>

    </form>

  </div>
{:catch error}
  <p style="color: red">Error: {JSON.stringify(error.response.data)}</p>
{/await}
