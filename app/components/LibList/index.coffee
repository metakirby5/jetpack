# A searchable listing of libs.

import {$} from 'myutil'
import {connect} from 'react-redux'
import {compose, graphql} from 'react-apollo'

import {q} from 'selectors'
import a from 'actions'
import {filteredByQuery} from 'selectors/libs'
import LibsQuery from 'query/libs'

# The redux connection.
reduxConn = connect(
  (state) ->
    query: q.query state
,
  ->
    onQueryChange: a.queryChange
)

# The GraphQL query connection.
gqlConn = graphql LibsQuery

# The functional component.
LibList = (p) ->
  $.div 0,
    $.input
      type: 'text'
      value: p.query
      onChange: (e) -> p.onQueryChange e.target.value
      placeholder: 'Type to search'
    if p.data.loading
      $.div 0,
        'LOADING...'
    else
      libs = filteredByQuery p
      $.ul 0, libs.map (lib, i) ->
        $.li key: i,
          $.a href: lib.url, target: '_blank',
            lib.name

export default (compose gqlConn, reduxConn) LibList
