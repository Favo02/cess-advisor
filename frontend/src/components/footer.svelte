<script>
  import { Footer, FooterBrand, FooterLinkGroup, FooterLink } from 'flowbite-svelte';
</script>

<Footer footerType="socialmedia">
  <div class="mx-auto max-w-screen-xl text-center mt-12">
    <FooterBrand href="/" src="/logo.png" alt="CessAdvisor Logo" aClass="flex justify-center items-center text-2xl font-semibold text-gray-900 dark:text-white" />
    <p class="my-6 text-gray-500 dark:text-gray-400">CessAdvisor, open source toilet review system.</p>
    <FooterLinkGroup ulClass="flex flex-wrap justify-center items-center mb-6 text-gray-900 dark:text-white">
      <FooterLink liClass="" aClass="mr-4 hover:underline md:mr-6" href="/">Home</FooterLink>
      <FooterLink liClass="" aClass="mr-4 hover:underline md:mr-6" href="/toilets">Toilets</FooterLink>
      <FooterLink liClass="" aClass="mr-4 hover:underline md:mr-6" href="/reviews">Reviews</FooterLink>
      <FooterLink liClass="" aClass="mr-4 hover:underline md:mr-6" href="/profile">Profile</FooterLink>
      <FooterLink liClass="" aClass="mr-4 hover:underline md:mr-6" href="/login">Login Program</FooterLink>
    </FooterLinkGroup>
    <span class="text-sm text-gray-500 sm:text-center dark:text-gray-400">I'm open source, under TBD licence</span>
  </div>
</Footer>
