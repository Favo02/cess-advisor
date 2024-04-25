<svelte:head>
  <title>CessAdvisor - New review</title>
</svelte:head>

<script>
  import Icon from "@iconify/svelte"
  import toast from "svelte-french-toast"
  import schemas from "../../../utils/schemas"
  import StarRating from "@ernane/svelte-star-rating"

  export let data
  export let form

  let toilet = data.toilet.id
  let rating = 3.5
  let description = ""
  let paper = false
  let soap = false
  let dryer = false
  let hotwater = false
  let clean = 2.5
  let temperature = 4.5

  function clientVerification(event) {
    const valid = schemas.review.safeParse({ toilet, rating, description, paper, soap, dryer, hotwater, clean, temperature })
    if (!valid.success) {
      const error = `Invalid ${valid.error.issues[0].path[0]}`
      toast.error(error)
      return
    }
    event.target.submit()
  }

  if (form?.error) {
    toast.error(form.error)
  }
</script>

<div class="w-full py-28 bg-base-300">
  <h1 class="mx-auto text-4xl text-center mb-3 font-bold"><span class="text-primary">Review</span> a toilet</h1>
  <p class="mx-auto text-lg text-center mb-10 italic">Thanks for sharing such a <b>precious</b> information.</p>

  <form class="max-w-sm mx-auto" method="POST" action="?/review" on:submit|preventDefault={(event) => clientVerification(event)}>

    <input type="hidden" name="toilet" bind:value={toilet}>

    <div class="mb-8">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Toilet</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="mingcute:toilet-paper-fill" class="w-5 h-5" />
        </div>
        <input type="text" readonly class="opacity-40 bg-base-100 border border-base-content/20 text-base-content text-sm rounded-lg focus-within:outline-none block w-full ps-10 p-2.5" value={data.toilet.title}>
      </div>
    </div>

    <div class="mb-8">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">University</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="mdi:university" class="w-5 h-5" />
        </div>
        <input type="text" readonly class="opacity-40 bg-base-100 border border-base-content/20 text-base-content text-sm rounded-lg focus-within:outline-none block w-full ps-10 p-2.5" value={data.toilet.university}>
      </div>
    </div>

    <div class="mb-8">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Place and building</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="clarity:building-solid" class="w-5 h-5" />
        </div>
        <input type="text" readonly class="opacity-40 bg-base-100 border border-base-content/20 text-base-content text-sm rounded-lg focus-within:outline-none block w-full ps-10 p-2.5" value={`${data.toilet.place} - ${data.toilet.building}`}>
      </div>
    </div>

    <div class="mb-4">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Rating</label>
      <div class="relative peer bg-base-100 py-4 rounded border border-base-content">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="ph:star-fill" class="w-5 h-5" />
        </div>
        <div class="mr-5">
          <StarRating
            on:change={() => rating = parseFloat(document.querySelector("input[name=rating]").value)}
            config={{
              readOnly: false,
              countStars: 5,
              range: {
                min: 0,
                max: 5,
                step: 0.5
              },
              score: rating,
              showScore: false,
              scoreFormat: undefined,
              name: "rating",
              starConfig: {
                size: 24,
                fillColor: "oklch(var(--p))",
                strokeColor: "oklch(var(--p))",
                unfilledColor: "oklch(var(--b3))",
                strokeUnfilledColor: "oklch(var(--b3))"
              }
            }}
          />
          <p class="absolute right-10 top-4">{rating} / 5</p>
        </div>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">Click on the stars or scroll with the mousewheel to set a value.</p>
    </div>

    <div>
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Description</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="bi:text-left" class="w-5 h-5" />
        </div>
        <textarea name="description" bind:value={description} class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block w-full ps-10 p-2.5 " placeholder="Moderno e pulito, ma non mi ha soddisfatto pienamente" rows=4></textarea>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">6 - 250 characters, ASCII extendended, no emoji, no control characters except space and newline</p>
    </div>

    <div class="mb-8 flex flex-row justify-between text-center">
      <div class="pr-10">
        <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content pl-10">Toilet paper</label>
        <div class="relative peer">
          <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
            <Icon icon="mingcute:toilet-paper-fill" class="w-5 h-5" />
          </div>
          <h2 class="absolute ml-10">NO</h2>
          <h2 class="absolute ml-36">YES</h2>
          <input type="checkbox" name="paper" bind:checked={paper} class="toggle border border-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block ps-10 ml-20 p-2.5" />
        </div>
      </div>
      <div class="pr-10">
        <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content pl-10">Soap</label>
        <div class="relative peer">
          <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
            <Icon icon="ph:hand-soap-bold" class="w-5 h-5" />
          </div>
          <h2 class="absolute ml-10">NO</h2>
          <h2 class="absolute ml-36">YES</h2>
          <input type="checkbox" name="soap" bind:checked={soap} class="toggle border border-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block ps-10 ml-20 p-2.5" />
        </div>
      </div>
    </div>

    <div class="mb-8 flex flex-row justify-between text-center">
      <div class="pr-10">
        <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content pl-10">Hands dryer</label>
        <div class="relative peer">
          <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
            <Icon icon="lucide:wind" class="w-5 h-5" />
          </div>
          <h2 class="absolute ml-10">NO</h2>
          <h2 class="absolute ml-36">YES</h2>
          <input type="checkbox" name="dryer" bind:checked={dryer} class="toggle border border-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block ps-10 ml-20 p-2.5" />
        </div>
      </div>
      <div class="pr-10">
        <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content pl-10">Hot water</label>
        <div class="relative peer">
          <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
            <Icon icon="carbon:temperature-water" class="w-5 h-5" />
          </div>
          <h2 class="absolute ml-10">NO</h2>
          <h2 class="absolute ml-36">YES</h2>
          <input type="checkbox" name="hotwater" bind:checked={hotwater} class="toggle border border-base-content text-sm rounded-lg focus:ring-primary focus:border-primary block ps-10 ml-20 p-2.5" />
        </div>
      </div>
    </div>

    <div class="mb-4">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Cleanliness</label>
      <div class="relative peer bg-base-100 py-4 rounded border border-base-content">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="iconoir:sparks-solid" class="w-5 h-5" />
        </div>
        <div class="mr-5">
          <StarRating
            on:change={() => clean = parseFloat(document.querySelector("input[name=clean]").value)}
            config={{
              readOnly: false,
              countStars: 5,
              range: {
                min: 0,
                max: 5,
                step: 0.5
              },
              score: clean,
              showScore: false,
              scoreFormat: undefined,
              name: "clean",
              starConfig: {
                size: 24,
                fillColor: "oklch(var(--p))",
                strokeColor: "oklch(var(--p))",
                unfilledColor: "oklch(var(--b3))",
                strokeUnfilledColor: "oklch(var(--b3))"
              }
            }}
          />
          <p class="absolute right-10 top-4">{clean} / 5</p>
        </div>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">Click on the stars or scroll with the mousewheel to set a value.</p>
    </div>

    <div class="mb-4">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Temperature</label>
      <div class="relative peer bg-base-100 py-4 rounded border border-base-content">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="bx:bxs-thermometer" class="w-5 h-5" />
        </div>
        <div class="mr-5">
          <StarRating
            on:change={() => temperature = parseFloat(document.querySelector("input[name=temperature]").value)}
            config={{
              readOnly: false,
              countStars: 5,
              range: {
                min: 0,
                max: 5,
                step: 0.5
              },
              score: temperature,
              showScore: false,
              scoreFormat: undefined,
              name: "temperature",
              starConfig: {
                size: 24,
                fillColor: "oklch(var(--p))",
                strokeColor: "oklch(var(--p))",
                unfilledColor: "oklch(var(--b3))",
                strokeUnfilledColor: "oklch(var(--b3))"
              }
            }}
          />
          <p class="absolute right-10 top-4">{temperature} / 5</p>
        </div>
      </div>
      <p class="text-xs m-2 text-center opacity-60 invisible peer-focus-within:visible">Click on the stars or scroll with the mousewheel to set a value.</p>
    </div>

    <button class="btn btn-primary mx-auto w-full mb-8" type="submit">
      <Icon icon="fluent:pen-16-filled" class="w-6 h-6" />
      Review
    </button>
    <a href="/toilets" class="btn btn-primary btn-outline mx-auto w-full">
      <Icon icon="pajamas:go-back" class="w-6 h-6" />
      Go back
    </a>

  </form>

</div>
