
<script>
  import { page } from "$app/stores"
  import Icon from "@iconify/svelte"
  import axios from "axios"
  import { onMount } from "svelte"
  import checkAuth from "../../utils/checkAuth"
  import toast from "svelte-french-toast"

  let toilet = $page.url.searchParams.get("t") || ""

  let loading = true

  onMount(async () => {
    if (!toilet) {
      window.location.href = "/toilets"
      return
    }

    if (!(await checkAuth())) {
      toast.error("You are not logged in")
      window.location.href = "/login"
    }
    loading = false
  })

  let rating = 0
  let description = ""
  let paper = false
  let soap = false
  let dryer = false
  let hotwater = false
  let clean = 0
  let temperature = 0

  async function handleSubmit() {

    try {
      const response = await axios.post(
        `${import.meta.env.VITE_API_URL}/api/reviews/create`,
        { toilet, rating, description, paper, soap, dryer, hotwater, clean, temperature },
        { withCredentials: true }
      )

      if (response.status === 200) {
        toast.success("Review created successfully")
        window.location.href = `/reviews?q=${toilet}`
      } else {
        toast.error("Error creating review")
      }

    } catch (error) {
      toast.error("Error creating review")
    }

  }

</script>

{#if loading}
  <div class="w-full min-h-screen py-28 bg-base-300 flex justify-center align-middle">
    <span class="loading loading-spinner loading-xl"></span>
  </div>
{/if}

<div class="w-full py-28 bg-base-300">
  <h1 class="mx-auto text-4xl text-center mb-3 font-bold"><span class="text-primary">Review</span> a toilet</h1>
  <p class="mx-auto text-lg text-center mb-10 italic">Thanks for sharing such a <b>precious</b> information.</p>

  <form class="max-w-sm mx-auto">

    <div>
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Rating (0 to 10)</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="ph:star-fill" class="w-5 h-5" />
        </div>
        <input type="number" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="0" bind:value={rating}>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">An integer value between 0 and 10, it will be scaled down to 5.</p>
    </div>

    <div>
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Description</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="bi:text-left" class="w-5 h-5" />
        </div>
        <textarea class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5 " placeholder="Moderno e pulito, ma non mi ha soddisfatto pienamente" rows=4 bind:value={description}></textarea>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">6 - 250 characters, ASCII extendended, no emoji, no control characters except space and newline</p>
    </div>

    <div class="mb-8">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Toilet paper</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="mingcute:toilet-paper-fill" class="w-5 h-5" />
        </div>
        <h2 class="absolute ml-10">NO</h2>
        <h2 class="absolute ml-36">YES</h2>
        <input type="checkbox" class="toggle border border-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block ps-10 ml-20 p-2.5" bind:checked={paper} />
      </div>
    </div>

    <div class="mb-8">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Soap</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="ph:hand-soap-bold" class="w-5 h-5" />
        </div>
        <h2 class="absolute ml-10">NO</h2>
        <h2 class="absolute ml-36">YES</h2>
        <input type="checkbox" class="toggle border border-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block ps-10 ml-20 p-2.5" bind:checked={soap} />
      </div>
    </div>

    <div class="mb-8">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Hands dryer</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="lucide:wind" class="w-5 h-5" />
        </div>
        <h2 class="absolute ml-10">NO</h2>
        <h2 class="absolute ml-36">YES</h2>
        <input type="checkbox" class="toggle border border-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block ps-10 ml-20 p-2.5" bind:checked={dryer} />
      </div>
    </div>

    <div class="mb-8">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Hot water</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="carbon:temperature-water" class="w-5 h-5" />
        </div>
        <h2 class="absolute ml-10">NO</h2>
        <h2 class="absolute ml-36">YES</h2>
        <input type="checkbox" class="toggle border border-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block ps-10 ml-20 p-2.5" bind:checked={hotwater} />
      </div>
    </div>

    <div>
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Cleanliness (0 to 10)</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="iconoir:sparks-solid" class="w-5 h-5" />
        </div>
        <input type="number" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="0" bind:value={clean}>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">An integer value between 0 and 10, it will be scaled down to 5.</p>
    </div>

    <div>
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Temperature (0 to 10)</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="bx:bxs-thermometer" class="w-5 h-5" />
        </div>
        <input type="number" class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5" placeholder="0" bind:value={temperature}>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">An integer value between 0 and 10, it will be scaled down to 5.</p>
    </div>

    <button class="btn btn-primary mx-auto w-full mb-8" on:click={handleSubmit}>
      <Icon icon="fluent:pen-16-filled" class="w-6 h-6" />
      Review
    </button>
    <a href="/toilets" class="btn btn-primary btn-outline mx-auto w-full">
      <Icon icon="pajamas:go-back" class="w-6 h-6" />
      Go back
    </a>

  </form>

</div>
