# A searchable listing of libs.

{connect} = require 'react-redux'
{DOM: d} = require 'react'

{$query, $libs} = require 'selectors'
{filteredByQuery} = require 'selectors/libs'
{queryChange} = require 'actions'

# The redux prop getter.
stateProps = (state) ->
  status: $libs(state).status
  query: $query state
  libs: filteredByQuery state

# The redux action dispatcher.
actionProps = (dispatch) ->
  onQueryChange: (query) -> dispatch queryChange query

# The functional component.
component = ({status, query, libs, onQueryChange}) ->
  d.div 0,
    d.input
      type: 'text'
      value: query
      onChange: (e) -> onQueryChange e.target.value
      placeholder: 'Type to search'
    d.ul 0, status ? libs.map (lib) ->
      d.li key: lib.name,
        d.a href: lib.url, target: '_blank',
          lib.name

module.exports = (connect stateProps, actionProps) component
