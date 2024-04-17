<script>
  import Icon from '@iconify/svelte';
</script>

<footer class="footer footer-center p-10 bg-base-200 text-base-content rounded">
  <nav class="grid grid-flow-col gap-4">
    <a href="/" class="link link-hover">Home</a>
    <a href="/toilets" class="link link-hover">Toilets</a>
    <a href="/reviews" class="link link-hover">Reviews</a>
    <a href="/profile" class="link link-hover">Profile</a>
  </nav>
  <nav>
    <div class="grid grid-flow-col gap-4">
      <a href="/"><img src="/logo.png" alt="CessAdvisor logo" class="h-12"></a>
    </div>
  </nav>
  <aside>
    <p>CessAdvisor - 2024 - I'm <a href="https://github.com/Favo02/cess-advisor" class="link">open source</a> <Icon icon="fa:external-link-square" class="inline"/>, under TDB license.</p>
  </aside>
</footer>
