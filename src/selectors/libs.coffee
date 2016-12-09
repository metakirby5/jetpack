{createSelector: cs} = require 'reselect'

{$query, $libs} = require 'selectors'

module.exports =
  filteredByQuery: cs [$query, $libs], (query, libs) ->
    query = query.trim().toLowerCase()
    if query.length
      libs = libs.filter (lib) -> lib.name.toLowerCase().match query
    libs
