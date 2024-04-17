<script>
  import "../app.pcss";

  import Header from "../components/header.svelte";
  import Footer from "../components/footer.svelte";
</script>

<Header />

<div class="">
  <slot />
</div>

<Footer />
