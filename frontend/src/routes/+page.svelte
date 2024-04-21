<script>
  import { onMount } from "svelte";
  import axios from "axios";
  import Icon from "@iconify/svelte";

  let loading = true;

  let users_count;
  let toilets_count;
  let reviews_count;

  onMount(async () => {
    try {
      const response = await axios.get(`${import.meta.env.VITE_API_URL}/api/stats`);
      users_count = response.data.users;
      toilets_count = response.data.toilets;
      reviews_count = response.data.reviews;
      loading = false;
    } catch (error) {
      console.error("Error fetching stats");
    }
  });
</script>

<div class="hero min-h-[calc(100vh-15rem)] bg-base-200">
  <div class="hero-content text-center">
    <div class="max-w-3xl">
      <h1 class="text-5xl font-bold">Know the <span class="text-primary">toilets</span> around you.</h1>
      <p class="py-6">Spread and gain knowledge about the arguably <span class="text-primary">most important room</span> in a building.</p>
      <a href="/toilets" role="button" class="btn btn-outline mr-3 mt-10">View Toilets</a>
      <a href="/login" role="button" class="btn btn-primary mt-10 ml-3">Login and leave a review</a>
    </div>
  </div>
</div>

<div class="w-full bg-base-200 flex justify-center pb-40">
  <div class="stats shadow-lg shadow-primary/20 flex flex-col md:grid">

    <div class="stat">
      <div class="stat-figure text-secondary">
        <Icon icon="heroicons:users-16-solid" class="h-12 w-12 text-primary" />
      </div>
      <div class="stat-title">Users</div>
      <div class="stat-value">
        {#if loading}
          <span class="loading loading-spinner loading-xs"></span>
        {:else}
          {users_count}
        {/if}
      </div>
      <div class="stat-desc">Profiles created</div>
    </div>

    <div class="stat">
      <div class="stat-figure text-secondary">
        <Icon icon="mingcute:toilet-paper-fill" class="h-12 w-12 text-primary" />
      </div>
      <div class="stat-title">Toilets</div>
      <div class="stat-value">
        {#if loading}
          <span class="loading loading-spinner loading-xs"></span>
        {:else}
          {toilets_count}
        {/if}
      </div>
      <div class="stat-desc">Toilets registereed</div>
    </div>

    <div class="stat">
      <div class="stat-figure text-secondary">
        <Icon icon="material-symbols:reviews" class="h-12 w-12 text-primary" />
      </div>
      <div class="stat-title">Reviews</div>
      <div class="stat-value">
        {#if loading}
          <span class="loading loading-spinner loading-xs"></span>
        {:else}
          {reviews_count}
        {/if}
      </div>
      <div class="stat-desc">Reviews written</div>
    </div>

  </div>
</div>
