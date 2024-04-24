<script>
  import { onMount } from "svelte"
  import themes from "../utils/themes"

  export let classes = ""

  let theme
  let check

  onMount(() => {
    theme = window.localStorage.getItem("theme") || "halloween"

    // force theme change by ticking and unticking the checkbox
    check = false
    check = true
  })

  function randomTheme() {
    let random = Math.floor(Math.random() * themes.length)
    while (theme == themes[random]) {
      random = Math.floor(Math.random() * themes.length)
    }

    theme = themes[random]
    window.localStorage.setItem("theme", theme)
    console.log(`The new theme is ${theme}!`)

    // force theme change by ticking and unticking the checkbox
    check = false
    check = true
  }
</script>

<button on:click={randomTheme} class="btn btn-primary {classes}">Change Theme</button>

<input type="checkbox" class="theme-controller hidden" aria-label={`${theme} theme`} bind:value={theme} bind:checked={check} />
