// wrapper around fetch, returns { ok, status, json, headers }
async function get(url, headers) {

  try {
    const response = await fetch(url, { headers })

    return {
      ok: response.ok,
      status: response.status,
      json: await response.json(),
      headers: response.headers,
    }

  } catch (err) {
    console.log(err)
    return { ok: false, status: 500, json: { "error": "API unavailable" }, headers: null }
  }

}

export default { get }
