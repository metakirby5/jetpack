# A searchable listing of libs.

{connect} = require 'react-redux'
{div, input, ul, li, a} = (require 'react').DOM

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
  div null,
    input
      type: 'text'
      value: query
      onChange: (e) ->
        onQueryChange e.target.value
      placeholder: 'Type to search'
    ul null,
      if status
        status
      else
        libs.map (lib) ->
          li key: lib.name,
            a href: lib.url, target: '_blank',
              lib.name

module.exports = (connect stateProps, actionProps) component
