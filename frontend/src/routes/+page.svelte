<script>
  import Icon from '@iconify/svelte';

  let loading = true;

  let users_count;
  let toilets_count;
  let reviews_count;

  fetch('/api/stats')
    .then(response => response.json())
    .then(data => {
      users_count = data.users;
      toilets_count = data.toilets;
      reviews_count = data.reviews;

      loading = false;
    });
</script>

<div class="hero min-h-[calc(100vh-20rem)] bg-base-200">
  <div class="hero-content text-center">
    <div class="max-w-3xl">
      <h1 class="text-5xl font-bold">Know the <span>toilets</span> around you.</h1>
      <p class="py-6">Spread and gain knowledge about the arguably <span>most important room</span> in a building.</p>
      <a href="/toilets" role="button" class="btn btn-outline mr-3 mt-10">View Toilets</a>
      <a href="/login" role="button" class="btn btn-primary mt-10 ml-3">Login and leave a review</a>
    </div>
  </div>
</div>

<div class="w-full bg-base-200 flex justify-center pb-40">
  <div class="stats shadow">

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
