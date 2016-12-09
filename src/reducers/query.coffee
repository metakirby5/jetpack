# By convention, the filename is the subtree of state this reducer manages.

{handleActions} = require 'redux-actions'

{QUERY_CHANGE} = require 'actions/types'

module.exports = handleActions
  "#{QUERY_CHANGE}": (state, {payload}) -> payload
, ''
