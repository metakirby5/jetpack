# By convention, code goes in components/component_name/index.coffee.
# This way, it can be required by directory name.

{Component, DOM} = require 'react'
{connect} = require 'react-redux'
{div, input, ul, li, a} = DOM

{container, main} = require './style'
{$query} = require 'selectors'
{filteredByQuery} = require 'selectors/libs'
{queryChange} = require 'actions/query'

# The redux prop getter.
stateProps = (state) ->
  query: $query state
  libs: filteredByQuery state

# The redux action dispatcher.
actionProps = (dispatch) ->
  onQueryChange: (query) -> dispatch queryChange query

# The functional component.
component = ({query, libs, onQueryChange}) ->
  div
    className: container
    div
      className: main
      input
        type: 'text'
        value: query
        onChange: (e) ->
          onQueryChange e.target.value
        placeholder: 'Type to search'
      ul null,
        libs.map (lib) ->
          li
            key: lib.name
            a
              href: lib.url
              target: '_blank'
              lib.name

module.exports = (connect stateProps, actionProps) component
