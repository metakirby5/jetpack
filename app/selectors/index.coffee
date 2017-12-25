# Auto-generated selectors for direct state subtrees.
# You shouldn't touch this.

{at, head} = require 'lodash'

# Programmatically create accessors.
# $path$to$reducer -> head at state, 'path.to.reducer'
reducerReq = require.context 'reducers', true, /^\.\/[^.]+[^/]$/
module.exports = reducerReq.keys().reduce ((a, n) ->
  if not n.match /\/(index)?$/
    field = n.slice 2
    a["$#{field.replace /\//g, '$'}"] = (state) ->
      head at state, field.replace /\//g, '.'
  a
),
  # Selector for GraphQL.
  sgql: (path) -> (state) -> head at state.data, path
