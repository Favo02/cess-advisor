// wrappers around fetch (GET and POST methods)
// always return an object, even in case of error:
// { ok: true|false, status: number, json: object, headers: object }

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

async function post(url, headers, body) {

  try {
    const response = await fetch(url, {
      headers,
      method: "POST",
      body: JSON.stringify(body)
    })

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

export default { get, post }
