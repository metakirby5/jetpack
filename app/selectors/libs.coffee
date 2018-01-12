# Selectors for libs.

import {createSelector as cs} from 'reselect'
import q, {apollo} from 'selectors'

export filteredByQuery =
  cs q.query, apollo('libs'), (query, libs) ->
    query = query.trim().toLowerCase()
    if query.length
      libs = libs.filter (lib) -> lib.name.toLowerCase().match query
    libs
