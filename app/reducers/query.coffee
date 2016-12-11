# By convention, the filename is the subtree of state this reducer manages.

{createReducer} = require 'redux-act'

{queryChange} = require 'actions'

module.exports = createReducer (act) ->
  act queryChange, (_, query) -> query
, ''
