/* eslint no-useless-escape: 0 */

const username = /^[\w\s\-.,!?:]{4,50}$/
const usernameDesc = "4-16 characters long, alphanumeric with underscore"

const password = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/
const passwordDesc = "8-20 characters, at least one letter, one number and one special character (@$!%*#?&)"

export default {
  username, usernameDesc,
  password, passwordDesc
}
