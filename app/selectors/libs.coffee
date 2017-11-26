# Selectors for libs.

{createSelector: cs} = require 'reselect'

{sgql, $query} = require 'selectors'

module.exports =
  filteredByQuery: cs $query, sgql('libs'), (query, libs) ->
    query = query.trim().toLowerCase()
    if query.length
      libs = libs.filter (lib) -> lib.name.toLowerCase().match query
    libs
