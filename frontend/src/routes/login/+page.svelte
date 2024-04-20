<script>
  import axios from "axios";

  let username = "";
  let password = "";
  let loading = false;

  async function handleSubmit() {
    try {
      loading = true;

      const response = await axios.post(`${import.meta.env.VITE_API_URL}/api/login`, { username, password });

      if (response.status === 200) {
        alert("Login successful");
      } else {
        alert("Login failed");
      }
    } catch (error) {
      alert("Login failed");
    } finally {
      loading = false;
    }
  }
</script>

<h1>Login</h1>

{#if loading}
  <p>Loading...</p>
{:else}
  <form on:submit|preventDefault={handleSubmit}>
    <label>
      Username:
      <input type="text" bind:value={username} />
    </label>
    <label>
      Password:
      <input type="password" bind:value={password} />
    </label>
    <button type="submit">Submit</button>
  </form>
{/if}
