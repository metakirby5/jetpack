# Reducer for query.

{createReducer} = require 'redux-act'

{queryChange} = require 'actions'

module.exports = createReducer (act) ->
  act queryChange, (_, query) -> query
, ''
