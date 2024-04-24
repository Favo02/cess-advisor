<script>
  import Theme from "./theme.svelte"

  export let route = "/"
</script>

<div class="navbar bg-base-100 px-20 shadow-lg shadow-primary/10 border-b border-primary/20 fixed z-50">
  <div class="navbar-start">
    <a href="/"><img src="/logo.png" alt="CessAdvisor logo" class="h-12"></a>
    <div class="dropdown">
      <div tabindex="0" role="button" class="btn btn-ghost lg:hidden">
        <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h8m-8 6h16" /></svg>
      </div>
      <ul tabindex="-1" class="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-52">
        <li class:text-primary={route == "/"}><a href="/">Home</a></li>
        <li class:text-primary={route == "/toilets"}><a href="/toilets">Toilets</a></li>
        <li class:text-primary={route == "/reviews"}><a href="/reviews">Reviews</a></li>
        <li class:text-primary={route == "/profile"}><a href="/profile">Profile</a></li>
        <li class:text-primary={route == "/login"}><a href="/login">Login</a></li>
      </ul>
    </div>
    <div class="relative">
      <a href="/" class="btn btn-ghost text-xl text-primary ml-4">CessAdvisor</a>
      <p class="absolute uppercase text-xs bottom-0 -right-[4px] text-primary font-black -rotate-[3deg] opacity-60">UNIVERSITY EDITION</p>
    </div>
  </div>

  <div class="navbar-center hidden lg:flex font-medium">
    <ul class="menu menu-horizontal px-1">
      <li class:text-primary={route == "/"}><a href="/">Home</a></li>
      <li class:text-primary={route == "/toilets"}><a href="/toilets">Toilets</a></li>
      <li class:text-primary={route == "/reviews"}><a href="/reviews">Reviews</a></li>
      <li class:text-primary={route == "/profile"}><a href="/profile">Profile</a></li>
      <li class:text-primary={route == "/login"}><a href="/login">Login</a></li>
    </ul>
  </div>

  <div class="navbar-end hidden md:inline-flex">
    <Theme />
  </div>
</div>
