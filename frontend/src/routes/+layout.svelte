<script>
  import "../app.pcss";

  import Header from "../components/header.svelte";
  import Footer from "../components/footer.svelte";
</script>

<Header />

<div class="mt-24">
  <slot />
</div>

<Footer />
