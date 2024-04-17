<script>
  import Theme from "./theme.svelte";
</script>

<div class="navbar bg-base-100 px-20">
  <div class="navbar-start">
    <a href="/"><img src="/logo.png" alt="CessAdvisor logo" class="h-12"></a>
    <div class="dropdown">
      <div tabindex="0" role="button" class="btn btn-ghost lg:hidden">
        <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h8m-8 6h16" /></svg>
      </div>
      <ul tabindex="-1" class="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-52">
        <li><a href="/">Home</a></li>
        <li><a href="/toilets">Toilets</a></li>
        <li><a href="/reviews">Reviews</a></li>
      </ul>
    </div>
    <a href="/" class="btn btn-ghost text-xl">CessAdvisor</a>
  </div>

  <div class="navbar-center hidden lg:flex">
    <ul class="menu menu-horizontal px-1">
      <li><a href="/">Home</a></li>
      <li><a href="/toilets">Toilets</a></li>
      <li><a href="/reviews">Reviews</a></li>
      <li><a href="/profile">Profile</a></li>
    </ul>
  </div>

  <div class="navbar-end">
    <Theme />
  </div>
</div>
