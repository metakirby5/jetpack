# Reducer for query.

{createReducer} = require 'redux-act'

{queryChange} = require 'actions'

module.exports = createReducer (act) ->
  act queryChange, (state, payload) -> payload
, ''
