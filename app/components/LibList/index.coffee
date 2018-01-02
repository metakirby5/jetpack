# A searchable listing of libs.

{$} = require 'myutil'

{connect} = require 'react-redux'
{compose, graphql} = require 'react-apollo'

{$query} = require 'selectors'
{filteredByQuery} = require 'selectors/libs'
{queryChange} = require 'actions'
LibsQuery = require 'query/libs'

# The redux connection.
reduxConn = connect(
  (state) ->
    query: $query state
,
  ->
    onQueryChange: (query) -> queryChange query
)

# The GraphQL query connection.
gqlConn = graphql LibsQuery

# The functional component.
LibList = (s) ->
  $.div 0,
    $.input
      type: 'text'
      value: s.query
      onChange: (e) -> s.onQueryChange e.target.value
      placeholder: 'Type to search'
    if s.data.loading
      $.div 0,
        'LOADING...'
    else
      libs = filteredByQuery s
      $.ul 0, libs.map (lib, i) ->
        $.li key: i,
          $.a href: lib.url, target: '_blank',
            lib.name

module.exports = (compose gqlConn, reduxConn) LibList
