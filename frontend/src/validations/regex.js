/* eslint no-useless-escape: 0 */

const username = /^[a-zA-Z0-9_]{4,16}$/
const usernameDesc = "4-16 characters long, alphanumeric with underscore"

const password = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/
const passwordDesc = "8-20 characters, at least one letter, one number and one special character (@$!%*#?&)"

const genericName = /^[\p{Alphabetic}\p{Number} ]{6,50}$/u
const genericNameDesc = "6-50 characters long, alphanumeric"

const genericDescription = /^[\p{Alphabetic}\p{Number} ]{6,200}$/u
const genericDescriptionDesc = "6-200 characters long, alphanumeric"

export default {
  username, usernameDesc,
  password, passwordDesc,
  genericName, genericNameDesc,
  genericDescription, genericDescriptionDesc
}
