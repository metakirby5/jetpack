{createSelector: cs} = require 'reselect'

{$query, $libs} = require 'selectors'

module.exports =
  filteredByQuery: cs $query, $libs, (query, libs) ->
    items = libs.items
    query = query.trim().toLowerCase()
    if query.length
      items = items.filter (lib) -> lib.name.toLowerCase().match query
    items
