<script>
  import Icon from "@iconify/svelte";
  import Theme from "./theme.svelte"
</script>
<footer class="footer footer-center p-10 bg-base-100 text-base-content shadow-[0_-10px_15px_3px] shadow-primary/5 border-t border-primary/20 z-50">
  <nav class="grid grid-flow-col gap-4">
    <a href="/" class="link link-hover">Home</a>
    <a href="/toilets" class="link link-hover">Toilets</a>
    <a href="/reviews" class="link link-hover">Reviews</a>
    <a href="/profile" class="link link-hover">Profile</a>
    <div><Theme classes="bg-transparent text-primary/60 border-none hover:text-primary hover:bg-transparent" /></div>
  </nav>
  <nav>
    <div class="flex flex-col justify-center gap-4">
      <a href="/" class="flex justify-center"><img src="/logo.png" alt="CessAdvisor logo" class="h-12"></a>
      <h1>CessAdvisor</h1>
    </div>
  </nav>
  <aside>
    <p class="text-md">
      <span>
        I'm <a href="https://github.com/Favo02/cess-advisor" class="link text-primary">open source <Icon icon="fa:external-link-square" class="inline w-3 h-3 text-primary"/></a>,
      </span>
      <span>
        under <a href="https://creativecommons.org/licenses/by/4.0/" class="link text-primary">CC-BY 4.0 <Icon icon="fa:external-link-square" class="inline w-3 h-3 text-primary"/></a> license.
      </span>
    </p>
    <p class="text-base-content/70">
      <a href="https://github.com/Favo02/cess-advisor/pulls" class="link">Contributions are welcome <Icon icon="fa:external-link-square" class="inline w-3 h-3"/></a>.
      <a href="https://github.com/Favo02/cess-advisor/issues" class="link">Report a bug <Icon icon="fa:external-link-square" class="inline w-3 h-3"/></a>.
    </p>
  </aside>
</footer>
