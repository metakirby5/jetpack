# A searchable listing of libs.

import {$} from 'myutil'
import {connect} from 'react-redux'
import {compose, graphql} from 'react-apollo'

import q from 'selectors'
import a from 'actions'
import {filteredByQuery} from 'selectors/libs'
import LibsQuery from 'query/libs'
import ApolloLoadable from 'components/ApolloLoadable'

# The redux connection.
redux = connect (state) ->
  query: q.query state
, ->
  onQueryChange: a.queryChange

# The functional component.
LibList = (p) ->
  $.div 0,
    $.input
      type: 'text'
      value: p.query
      onChange: (e) -> p.onQueryChange e.target.value
      placeholder: 'Type to search'
    $ ApolloLoadable, data: p.data, loader: ->
      libs = filteredByQuery p
      $.ul 0, libs.map (lib, i) ->
        $.li key: i,
          $.a href: lib.url, target: '_blank',
            lib.name

export default (compose redux, graphql LibsQuery) LibList
