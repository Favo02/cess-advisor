<script>
  import Icon from "@iconify/svelte"

  export let review;
  export let filter;

  const {
    id,
    toilet_id,
    title,
    place,
    building,
    author_id,
    author_name,
    date,
    rating,
    description,
    paper,
    soap,
    dryer,
    hotwater,
    clean,
    temperature
  } = review;

  let goodness = {
    0: ["Terrible", "bg-red-500", "text-red-900"],
    1: ["Very bad", "bg-red-400", "text-red-700"],
    2: ["Bad", "bg-yellow-500", "text-yellow-800"],
    3: ["Average", "bg-yellow-400", "text-yellow-700"],
    4: ["Good", "bg-green-500", "text-green-800"],
    5: ["Very good", "bg-green-400", "text-green-700"]
  };

  function formatDate(date) {
    return new Date(date).toLocaleString();
  }
</script>


<div class="w-[400px] mx-auto min-h-40 p-4">
  <div class="block bg-base-100 shadow-lg shadow-primary/20 rounded-lg overflow-hidden">

    <div class="p-4">
      <h2 class="mt-2 mb-2 font-bold text-primary"><a href="/reviews?q={toilet_id}" on:click={() => filter = toilet_id} class="link">{title || "Unnamed toilet"}</a>
        <span class="{goodness[Math.round(rating / 2)][1]} {goodness[Math.round(rating / 2)][2]} inline ml-2 px-2 py-1 leading-none rounded-full font-semibold uppercase tracking-wide text-xs">{goodness[Math.round(rating / 2)][0]}</span>
      </h2>
      <p class="text-sm font-bold mb-2">{building} - {place}</p>
    </div>

    <div class="pb-5 px-4 text-xs text-neutral-content flex items-center justify-center gap-5">
      <div class="rating">
        {#each Array(Math.round(rating/2)) as _}
          <Icon icon="ic:baseline-star" class="w-6 h-6 text-primary" />
        {/each}
        {#each Array(5 - Math.round(rating/2)) as _}
          <Icon icon="ic:baseline-star" class="w-6 h-6 text-primary/20" />
        {/each}
      </div>
      <div class="text-md font-bold">
        <span class="text-primary text-lg">{rating / 2}</span> out of 5
      </div>
    </div>

    <p class="mx-5 text-sm">{description}</p>

    <div class="flex mt-5 mb-3 w-full justify-center items-center flex-col">
      <h4>
        <Icon icon="mingcute:toilet-paper-fill" class="w-6 h-6 inline" />
        Paper: <span class="uppercase text-xs font-bold text-primary/70">{paper ? "Yes" : "No"}</span>
      </h4>
      <h4>
        <Icon icon="ph:hand-soap-bold" class="w-6 h-6 inline" />
        Soap: <span class="uppercase text-xs font-bold text-primary/70">{soap ? "Yes" : "No"}</span>
      </h4>
      <h4>
        <Icon icon="lucide:wind" class="w-6 h-6 inline" />
        Hands dryer: <span class="uppercase text-xs font-bold text-primary/70">{dryer ? "Yes" : "No"}</span>
      </h4>
      <h4>
        <Icon icon="carbon:temperature-water" class="w-6 h-6 inline" />
        Hot water: <span class="uppercase text-xs font-bold text-primary/70">{hotwater ? "Yes" : "No"}</span>
      </h4>
      <h4>
        <Icon icon="iconoir:sparks-solid" class="w-6 h-6 inline" />
        Cleanliness: <span class="uppercase text-xs font-bold text-primary/70">{clean / 2} out of 5</span>
      </h4>
      <h4>
        <Icon icon="bx:bxs-thermometer" class="w-6 h-6 inline" />
        Temperature: <span class="uppercase text-xs font-bold text-primary/70">{temperature / 2} out of 5</span>
      </h4>

    </div>

    <div class="p-4 flex items-center text-xs text-neutral-content/70">
      Review by {author_name || "Anonymous"} on {formatDate(date)}
    </div>
  </div>
</div>

