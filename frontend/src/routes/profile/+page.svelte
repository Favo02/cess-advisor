<svelte:head>
  <title>CessAdvisor - Profile</title>
</svelte:head>

<script>
  import Icon from "@iconify/svelte"
  import toast from "svelte-french-toast"

  export let data
  export let form

  if (form?.error) {
    toast.error(form.error)
  }
</script>

<div class="w-full py-28 bg-base-300">
  <h1 class="mx-auto text-4xl text-center mb-3 font-bold">Hello <span class="text-primary">{data.profile.username}</span></h1>
  <p class="mx-auto text-lg text-center mb-10 italic">Here's your <span class="font-bold">profile</span>.</p>

  <form class="max-w-sm mx-auto mt-20">

    <div class="pb-6">
      <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Username</label>
      <div class="relative peer">
        <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
          <Icon icon="clarity:user-solid" class="w-5 h-5" />
        </div>
        <input type="text" readonly class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg opacity-60 block w-full ps-10 p-2.5 focus-visible:outline-none" placeholder="User" value={data.profile.username}>
      </div>
    </div>

    <div class="pb-8 flex flex-row">
      <div class="pr-4">
        <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Toilets created</label>
        <div class="relative peer">
          <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
            <Icon icon="mingcute:toilet-paper-fill" class="w-5 h-5" />
          </div>
          <input type="text" readonly class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg opacity-60 block w-full ps-10 p-2.5 focus-visible:outline-none" placeholder="P4s$w0rd" value={data.profile.toilets_created}>
        </div>
      </div>
      <div class="pl-4">
        <label for="ignore" class="block mb-2 ml-2 text-md font-medium text-base-content">Reviews authored</label>
        <div class="relative peer">
          <div class="absolute inset-y-0 start-0 flex items-center ps-3.5 pointer-events-none">
            <Icon icon="material-symbols:reviews" class="w-5 h-5" />
          </div>
          <input type="text" readonly class="bg-base-100 border border-base-content text-base-content text-sm rounded-lg opacity-60 block w-full ps-10 p-2.5 focus-visible:outline-none" placeholder="P4s$w0rd" value={data.profile.reviews_authored}>
        </div>
      </div>
    </div>

    <div class="flex flex-row">
      <a href="/toilets?q={data.profile.user_id}" class="rounded-lg btn btn-primary btn-outline mx-auto w-[calc(50%-16px)] mr-4 mb-8">
        <Icon icon="mingcute:toilet-paper-fill" class="w-6 h-6" />
        Your toilets
      </a>

      <a href="/reviews?q={data.profile.user_id}" class="rounded-lg btn btn-primary btn-outline mx-auto w-[calc(50%-16px)] ml-4 mb-8">
        <Icon icon="material-symbols:reviews" class="w-6 h-6" />
        Your reviews
      </a>
    </div>

    <button disabled class="btn btn-primary btn-outline mx-auto w-full mb-8">
      <Icon icon="lucide:edit" class="w-6 h-6" />
      Edit profile <span class="italic">(coming soon)</span>
    </button>
    <form method="POST" action="?/logout">
      <button class="btn btn-primary mx-auto w-full" type="submit">
        <Icon icon="carbon:logout" class="w-6 h-6" />
        Logout
      </button>
    </form>

  </form>

</div>
