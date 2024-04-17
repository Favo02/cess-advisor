<script>
  let theme;
  let check;

  const themes = [
    "light",
    "dark",
    "cupcake",
    "bumblebee",
    "emerald",
    "corporate",
    "synthwave",
    "retro",
    "cyberpunk",
    "valentine",
    "halloween",
    "garden",
    "forest",
    "aqua",
    "lofi",
    "pastel",
    "fantasy",
    "wireframe",
    "black",
    "luxury",
    "dracula",
    "cmyk",
    "autumn",
    "business",
    "acid",
    "lemonade",
    "night",
    "coffee",
    "winter",
    "dim",
    "nord",
    "sunset",
  ];

  function randomTheme() {
    let random = Math.floor(Math.random() * themes.length);
    while (theme == themes[random]) {
      random = Math.floor(Math.random() * themes.length);
    }
    theme = themes[random];
    console.log(`The new theme is ${theme}!`)
    check = false;
    check = true;
  }

</script>

<button on:click={randomTheme} class="btn btn-primary">Change Theme</button>

<input type="checkbox" class="theme-controller hidden" aria-label={`${theme} theme`} value={theme} checked={check} />
