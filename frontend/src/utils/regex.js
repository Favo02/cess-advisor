const username = /^[a-zA-Z0-9]{4,16}$/
const password = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/

const genericShortText = /^[\t\n\x20-\xFF]{6,50}$/
const genericLongText = /^[\t\n\x20-\xFF]{6,250}$/

export default {
  username,
  password,
  genericShortText,
  genericLongText,
}
