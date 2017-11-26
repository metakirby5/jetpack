# Simple actions.

{fromPairs} = require 'lodash'
{createAction} = require 'redux-act'

# Generate action map.
module.exports = fromPairs [
  'queryChange'
].map (action) -> [action, createAction action]
