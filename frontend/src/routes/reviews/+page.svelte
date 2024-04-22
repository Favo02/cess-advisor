<svelte:head>
  <title>CessAdvisor - Reviews</title>
</svelte:head>

<script>
  import axios from "axios"
  import Icon from "@iconify/svelte"
  import ReviewCard from "./reviewCard.svelte"
  import { replaceState } from "$app/navigation"
  import { page } from "$app/stores"

  let promise = axios.get(`${import.meta.env.VITE_API_URL}/api/reviews`)

  let filter = $page.url.searchParams.get("q") || ""

  function updateFilter(event) {
    replaceState(`/reviews?q=${event.target.value}`)
    filter = event.target.value
  }

  function isValid(review) {
    const { toilet_id, title, place, building, author_name, description } = review
    return (
      toilet_id.toLowerCase().includes(filter) ||
      title.toLowerCase().includes(filter) ||
      place.toLowerCase().includes(filter) ||
      building.toLowerCase().includes(filter) ||
      author_name.toLowerCase().includes(filter) ||
      description.toLowerCase().includes(filter)
    )
  }

</script>

{#await promise}
  <div class="w-full min-h-screen py-28 bg-base-300 flex justify-center align-middle">
    <span class="loading loading-spinner loading-xl"></span>
  </div>
{:then reviews}
  <div class="w-full py-28 bg-base-300">
    <h1 class="mx-auto text-4xl text-center mb-3 font-bold"><span class="text-primary">Reviews</span> available</h1>
    <p class="mx-auto text-lg text-center mb-10 italic">Visit <a href="/toilets" class="text-primary link">/toilets</a> page to leave a review.</p>

    <div class="flex flex-col max-w-[90%] mx-auto justify-center md:flex-row">
      <label class="input input-bordered flex items-center gap-2 max-w-[600px] md:mx-8 mb-2">
        <input type="text" class="grow min-w-[400px]" placeholder="Search" on:input={updateFilter} bind:value={filter} />
        <Icon icon="ic:baseline-search" class="w-6 h-6" />
      </label>
    </div>
    <h3 class="mx-auto text-sm text-center mb-10 italic">Filter by bathroom <b>title</b>, <b>place</b> and <b>building</b> or by review <b>author</b> and <b>description</b>!</h3>

    <div class="max-w-[1300px] mx-auto flex flex-col md:flex-row justify-center">

      {#if reviews.data.filter(t => isValid(t, filter)).length === 0}
        <p class="text-center text-xl font-bold mt-5">No reviews found :(</p>
      {:else}
        {#each [0, 1, 2] as rem}
          <div>
            {#each reviews.data.filter(t => isValid(t, filter)) as review, i (review.id)}
              {#if i % 3 === rem}
                <ReviewCard {review} bind:filter={filter} />
              {/if}
            {/each}
          </div>
        {/each}
      {/if}

    </div>
  </div>
{:catch error}
  <div class="w-full py-28 bg-base-300 min-h-[calc(100vh-15rem)] flex justify-center align-middle flex-col">
    <h1 class="mx-auto text-4xl text-center mb-3 font-bold">There was an <span class="text-primary">error</span> fetching reviews</h1>
    <p class="mx-auto text-lg text-center mb-10 italic">Please try to refresh.</p>
  </div>
{/await}
