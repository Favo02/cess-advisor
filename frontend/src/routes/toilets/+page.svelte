<svelte:head>
  <title>CessAdvisor - Toilets</title>
</svelte:head>

<script>
  import ToiletCard from "./toiletCard.svelte"
  import Icon from "@iconify/svelte"
  import { replaceState } from "$app/navigation"
  import { page } from "$app/stores"

  export let data

  let filter = $page.url.searchParams.get("q") || ""

  function updateFilter(event) {
    replaceState(`/toilets?q=${event.target.value}`)
    filter = event.target.value
  }

  function isValid(toilet) {
    let lowFilter = filter.toLowerCase()
    const { id, title, university, place, building, creator_name, creator_id, description } = toilet
    return (
      id.toLowerCase().includes(lowFilter) ||
      title.toLowerCase().includes(lowFilter) ||
      university.toLowerCase().includes(lowFilter) ||
      place.toLowerCase().includes(lowFilter) ||
      building.toLowerCase().includes(lowFilter) ||
      creator_name.toLowerCase().includes(lowFilter) ||
      creator_id.toLowerCase().includes(lowFilter) ||
      description.toLowerCase().includes(lowFilter)
    )
  }
</script>

<div class="w-full py-28 bg-base-300">
  <h1 class="mx-auto text-4xl text-center mb-3 font-bold">Toilets <span class="text-primary">someone</span> created</h1>
  <p class="mx-auto text-lg text-center mb-10 italic">Please verify if someone <b>already created</b> the toilet you want to <b>review</b> before creating it.</p>

  <div class="flex flex-col max-w-[90%] mx-auto justify-center md:flex-row">
    <label class="input input-bordered flex items-center gap-2 max-w-[600px] md:ml-[150px] md:mr-8 mb-2">
      <input type="text" class="grow min-w-[400px]" placeholder="Search" on:input={updateFilter} />
      <Icon icon="ic:baseline-search" class="w-6 h-6" />
    </label>
    <a href="/toilets/new" class="btn btn-primary">New toilet</a>
  </div>
  <h3 class="mx-auto text-sm text-center mb-10 italic">Filter by <b>title</b>, <b>university</b>, <b>place</b>, <b>building</b>, <b>description</b> or <b>creator</b>!</h3>

  <div class="max-w-[1300px] mx-auto flex flex-col md:flex-row justify-center">

    {#if data.toilets.filter(t => isValid(t, filter)).length === 0}
      <p class="text-center text-xl font-bold mt-5">No toilets found :(</p>
    {:else}
      {#each [0, 1, 2] as rem}
        <div>
          {#each data.toilets.filter(t => isValid(t, filter)) as toilet, i (toilet.id)}
            {#if i % 3 === rem}
              <ToiletCard {toilet} />
            {/if}
          {/each}
        </div>
      {/each}
    {/if}

  </div>
</div>
