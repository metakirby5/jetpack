# By convention, the filename is the subtree of state this reducer manages.

{QUERY_CHANGE} = require 'actions/types'

module.exports = (state = '', action) ->
  switch action.type
    when QUERY_CHANGE then action.query
    else state
