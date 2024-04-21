<script>
  import axios from "axios";

  let promise = axios.get(`${import.meta.env.VITE_API_URL}/api/users/me`);
</script>

<h1>Profile</h1>

{#await promise}
  <p>Loading...</p>
{:then profile}
  <p>Profile: {JSON.stringify(profile.data)}</p>
{:catch error}
  <p style="color: red">Error: {JSON.stringify(error.response.data)}</p>
{/await}
