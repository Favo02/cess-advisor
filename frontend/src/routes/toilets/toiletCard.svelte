<script>
  import StarRating from "@ernane/svelte-star-rating"

  export let toilet

  const {
    id,
    creator_name,
    creator_id,
    creation_date,
    title,
    university,
    building,
    place,
    description,
    rating,
    reviews_count
  } = toilet

  let goodness = {
    0: ["Terrible", "bg-red-500", "text-red-900"],
    1: ["Very bad", "bg-red-400", "text-red-700"],
    2: ["Bad", "bg-yellow-500", "text-yellow-800"],
    3: ["Average", "bg-yellow-400", "text-yellow-700"],
    4: ["Good", "bg-green-500", "text-green-800"],
    5: ["Very good", "bg-green-400", "text-green-700"]
  }

  function formatDate(date) {
    return new Date(date).toLocaleDateString()
  }
</script>


<div class="w-[400px] mx-auto min-h-40 p-4">
  <div class="block bg-base-100 shadow-lg shadow-primary/20 rounded-lg overflow-hidden">

    <div class="p-4">
      <p class="text-xs font-bold mb-2 uppercase text-center">{university}</p>
      <h2 class="mt-2 mb-2 font-bold text-primary"><a href="/reviews?q={id}" class="link">{title || "Unnamed toilet"}</a>
        {#if reviews_count > 0}
          <span class="{goodness[Math.round(rating / 2)][1]} {goodness[Math.round(rating / 2)][2]} inline ml-2 px-2 py-1 leading-none rounded-full font-semibold uppercase tracking-wide text-xs">{goodness[Math.round(rating / 2)][0]}</span>
        {:else}
          <span class="bg-gray-500 text-gray-800 inline ml-2 px-2 py-1 leading-none rounded-full font-semibold uppercase tracking-wide text-xs">NO REVIEWS</span>
        {/if}
      </h2>
      <p class="text-sm font-bold mb-2">{building} - {place}</p>
      <p class="text-sm">{description}</p>
    </div>

    {#if reviews_count > 0}
      <div class="p-4 text-xs flex items-center justify-center gap-5">
        <StarRating config={{
          readOnly: true,
          countStars: 5,
          range: {
            min: 0,
            max: 5,
            step: 0.5
          },
          score: rating / 2,
          showScore: false,
          scoreFormat: undefined,
          name: "",
          starConfig: {
            size: 24,
            fillColor: "oklch(var(--p))",
            strokeColor: "oklch(var(--p))",
            unfilledColor: "oklch(var(--b3))",
            strokeUnfilledColor: "oklch(var(--b3))"
          }
        }} />
        <div class="text-md font-bold">
          <span class="text-primary text-lg">{parseFloat((rating / 2).toFixed(2))}</span> based on {reviews_count} reviews
        </div>
      </div>
    {/if}

    <div class="flex justify-center align-middle gap-4">
      {#if reviews_count > 0}
        <a href="/reviews?q={id}" class="btn btn-primary btn-outline">View reviews</a>
      {/if}
      <a href="/review/{id}" class="btn btn-primary">Review</a>
    </div>

    <div class="p-4 flex items-center text-xs opacity-70">
      Created by {creator_name || "Anonymous"} on {formatDate(creation_date)}
    </div>
  </div>
</div>

