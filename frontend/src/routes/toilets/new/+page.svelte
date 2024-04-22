<script>
  import Icon from "@iconify/svelte"
  import axios from "axios"
  import { onMount } from "svelte"
  import checkAuth from "../../../utils/checkAuth"
  import toast from "svelte-french-toast"
  import schemas from "../../../utils/schemas"

  let title = ""
  let building = ""
  let place = ""
  let description = ""

  let loading = true

  onMount(async () => {
    if (!(await checkAuth())) {
      toast.error("You are not logged in")
      window.location.href = "/login"
    }
    loading = false
  })

  async function handleSubmit() {

    const valid = schemas.toilet.safeParse({ title, building, place, description })
    if (!valid.success) {
      toast.error(`Invalid ${valid.error.issues[0].path[0]}`)
      loading = false
      return
    }

    try {
      const response = await axios.post(
        `${import.meta.env.VITE_API_URL}/api/toilets/create`,
        { title, building, place, description },
        { withCredentials: true }
      )

      if (response.status === 200) {
        toast.success("Toilet created successfully")
        window.location.href = "/toilets"
      } else {
        toast.error("Error creating toilet")
      }

    } catch (error) {
      toast.error("Error creating toilet")
    }

  }

</script>

{#if loading}
  <div class="w-full min-h-screen py-28 bg-base-300 flex justify-center align-middle">
    <span class="loading loading-spinner loading-xl"></span>
  </div>
{/if}

<div class="w-full py-28 bg-base-300">
  <h1 class="mx-auto text-4xl text-center mb-3 font-bold">Create new <span class="text-primary">toilet</span></h1>
  <p class="mx-auto text-lg text-center mb-10 italic">Please verify if someone <b>already created</b> the toilet you want to <b>review</b> before creating it.</p>

  <form class="max-w-sm mx-auto">

    <div class="">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Title</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="fluent:text-case-title-16-filled" class="w-5 h-5" />
        </div>
        <input type="text" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="Bagno del Silab" bind:value={title}>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">6 - 50 characters, ASCII extendended, no emoji, no control characters except space and newline</p>
    </div>

    <div class="">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Building</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="clarity:building-solid" class="w-5 h-5" />
        </div>
        <input type="text" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="Dipartimento di informatica, UNIMI" bind:value={building}>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">6 - 50 characters, ASCII extendended, no emoji, no control characters except space and newline</p>
    </div>

    <div class="">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Place</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="mdi:address-marker" class="w-5 h-5" />
        </div>
        <input type="text" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5 " placeholder="Celoria 18" bind:value={place}>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">6 - 50 characters, ASCII extendended, no emoji, no control characters except space and newline</p>
    </div>

    <div class="">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Description</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="bi:text-left" class="w-5 h-5" />
        </div>
        <textarea class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5 " placeholder="Bagno a sinistra (uscendo) dal Silab" rows=4 bind:value={description}></textarea>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">6 - 250 characters, ASCII extendended, no emoji, no control characters except space and newline</p>
    </div>

    <button class="btn btn-primary mx-auto w-full mb-8" on:click={handleSubmit}>
      <Icon icon="lucide:copy-plus" class="w-6 h-6" />
      Create
    </button>
    <a href="/toilets" class="btn btn-primary btn-outline mx-auto w-full">
      <Icon icon="pajamas:go-back" class="w-6 h-6" />
      Go back
    </a>

  </form>

</div>
