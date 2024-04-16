<script>
  import { Heading, Span, Mark, GradientButton } from 'flowbite-svelte';
  import { ArrowRightOutline } from 'flowbite-svelte-icons';
</script>

  <div class="flex flex-col justify-center align-middle h-[calc(100vh-14rem)]">

    <Heading tag="h1" class="text-center">
      Know the <Mark>toilets</Mark> around you.
    </Heading>

    <Heading tag="h5" class="mt-8 text-center">Spread and gain knowledge about the arguably <Span gradient>most important room</Span> in a building.</Heading>

    <div class="flex mt-10 justify-center gap-6">
      <GradientButton class="w-fit" outline href="/toilets">Explore toilets <ArrowRightOutline class="w-5 h-5 ms-2" /></GradientButton>
      <GradientButton class="w-fit" href="/toilets">Register and leave a review <ArrowRightOutline class="w-5 h-5 ms-2" /></GradientButton>
    </div>

  </div>

