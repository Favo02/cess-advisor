<svelte:head>
  <title>CessAdvisor - Home</title>
</svelte:head>

<script>
  import Icon from "@iconify/svelte"

  export let data
</script>


<div class="w-full py-60 bg-base-300">

  {#if data.issues.length > 0}
    <div class="opacity-40 mx-auto mb-8 text-center max-w-[300px] rounded-md border-2 border-red-600 bg-red-400 px-10 py-2 text-black">
      <a href="https://github.com/Favo02/cess-advisor/issues" target="_blank" class="link">{data.issues.length} Known issues <Icon icon="fa:external-link-square" class="inline w-3 h-3"/>
    </div>
  {/if}
  <h1 class="mx-auto text-5xl text-center mb-3 font-bold">Know the <span class="text-primary">toilets</span> around you</h1>
  <p class="py-6 text-center">Spread and gain knowledge about the arguably <span class="text-primary">most important room</span> in a building.</p>
  <div class="w-full flex justify-center">
    <a href="/toilets" role="button" class="btn btn-outline mr-3 mt-10">View Toilets</a>
    <a href="/login" role="button" class="btn btn-primary mt-10 ml-3">Login and leave a review</a>
  </div>

  <div class="w-full bg-base-300 flex justify-center pt-32">
    <div class="stats shadow-lg shadow-primary/20 flex flex-col md:grid">

      <div class="stat">
        <div class="stat-figure text-secondary">
          <Icon icon="heroicons:users-16-solid" class="h-12 w-12 text-primary" />
        </div>
        <div class="stat-title">Users</div>
        <div class="stat-value">{data.stats.users}</div>
        <div class="stat-desc">Profiles created</div>
      </div>

      <div class="stat">
        <div class="stat-figure text-secondary">
          <Icon icon="mingcute:toilet-paper-fill" class="h-12 w-12 text-primary" />
        </div>
        <div class="stat-title">Toilets</div>
        <div class="stat-value">{data.stats.toilets}</div>
        <div class="stat-desc">Toilets registereed</div>
      </div>

      <div class="stat">
        <div class="stat-figure text-secondary">
          <Icon icon="material-symbols:reviews" class="h-12 w-12 text-primary" />
        </div>
        <div class="stat-title">Reviews</div>
        <div class="stat-value">{data.stats.reviews}</div>
        <div class="stat-desc">Reviews written</div>
      </div>

    </div>
  </div>
</div>
