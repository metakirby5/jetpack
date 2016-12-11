actions = [
  'QUERY_CHANGE'
]

# Generate type map
module.exports = actions.reduce ((a, n) ->
  a[n] = n
  a
), {}
