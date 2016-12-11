# Simple actions.

{createAction} = require 'redux-act'

actions = [
  'queryChange'
  'requestLibs'
  'receiveLibs'
  'errorLibs'
]

# Generate action map
module.exports = actions.reduce ((a, n) ->
  a[n] = createAction n
  a
), {}
