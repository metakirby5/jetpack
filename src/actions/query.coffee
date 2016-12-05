{QUERY_CHANGE} = require './types'

module.exports =
  queryChange: (query) ->
    type: QUERY_CHANGE
    query: query
