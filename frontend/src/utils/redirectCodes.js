export default {
  // 2xx: operation successfull (login successful, resource created, ...)
  "201": { msg: "Logged in successfully", isError: false },
  "202": { msg: "Logged out successfully", isError: false },
  "203": { msg: "Review created successfully", isError: false },
  "204": { msg: "Toilet created successfully", isError: false },

  // 4xx: authorization errors (login required, already logged in, ...)
  "401": { msg: "Please login to access this page", isError: true },
  "402": { msg: "You are already logged in", isError: true },
}
