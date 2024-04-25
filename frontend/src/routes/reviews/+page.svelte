<svelte:head>
  <title>CessAdvisor - Reviews</title>
</svelte:head>

<script>
  import Icon from "@iconify/svelte"
  import ReviewCard from "./reviewCard.svelte"
  import { replaceState } from "$app/navigation"
  import { page } from "$app/stores"

  export let data

  let filter = $page.url.searchParams.get("q") || ""

  function updateFilter(event) {
    replaceState(`/reviews?q=${event.target.value}`)
    filter = event.target.value
  }

  function isValid(review) {
    let lowFilter = filter.toLowerCase()
    const { toilet_id, title, university, place, building, author_name, author_id, description } = review
    return (
      toilet_id.toLowerCase().includes(lowFilter) ||
      title.toLowerCase().includes(lowFilter) ||
      university.toLowerCase().includes(lowFilter) ||
      place.toLowerCase().includes(lowFilter) ||
      building.toLowerCase().includes(lowFilter) ||
      author_name.toLowerCase().includes(lowFilter) ||
      author_id.toLowerCase().includes(lowFilter) ||
      description.toLowerCase().includes(lowFilter)
    )
  }

</script>


<div class="w-full py-28 bg-base-300">
  <h1 class="mx-auto text-4xl text-center mb-3 font-bold"><span class="text-primary">Reviews</span> available</h1>
  <p class="mx-auto text-lg text-center mb-10 italic">Visit <a href="/toilets" class="text-primary link font-bold">toilets</a> page to leave a <span class="font-bold">review</span>.</p>

  <div class="flex flex-col max-w-[90%] mx-auto justify-center md:flex-row">
    <label class="input input-bordered flex items-center gap-2 max-w-[600px] md:mx-8 mb-2">
      <input type="text" class="grow min-w-[400px]" placeholder="Search" on:input={updateFilter} bind:value={filter} />
      <Icon icon="ic:baseline-search" class="w-6 h-6" />
    </label>
  </div>
  <h3 class="mx-auto text-sm text-center mb-10 italic">Filter by bathroom <b>title</b>, <b>university</b>, <b>place</b>, <b>building</b> or by review <b>author</b>, <b>description</b>!</h3>

  <div class="max-w-[1300px] mx-auto flex flex-col md:flex-row justify-center">

    {#if data.reviews.filter(t => isValid(t, filter)).length === 0}
      <p class="text-center text-xl font-bold mt-5">No reviews found :(</p>
    {:else}
      {#each [0, 1, 2] as rem}
        <div>
          {#each data.reviews.filter(t => isValid(t, filter)) as review, i (review.id)}
            {#if i % 3 === rem}
              <ReviewCard {review} bind:filter={filter} />
            {/if}
          {/each}
        </div>
      {/each}
    {/if}

  </div>
</div>
