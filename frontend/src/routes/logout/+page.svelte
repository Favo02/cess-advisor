<script>
  import axios from "axios";

  let loading = false;

  async function handleSubmit() {
    try {
      loading = true;

      const response = await axios.post(`${import.meta.env.VITE_API_URL}/api/logout`);

      if (response.status === 200) {
        alert("Logout successful");
      } else {
        alert("Logout failed");
      }
    } catch (error) {
      alert("Logout failed");
    } finally {
      loading = false;
    }
  }
</script>

<h1>Logout</h1>

{#if loading}
  <p>Loading...</p>
{:else}
  <form on:submit|preventDefault={handleSubmit}>
    <button type="submit">Logout</button>
  </form>
{/if}
