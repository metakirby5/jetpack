# By convention, code goes in components/component_name/index.coffee.
# This way, it can be required by directory name.

{Component, DOM} = require 'react'
{connect} = require 'react-redux'
{div, input, ul, li, a} = DOM

{container, main} = require './style'
{queryChange} = require 'actions/query'

# Lifted from http://gaearon.github.io/react-hot-loader/

BEST_JS_LIBS = [
  {name: 'Backbone.js', url: 'http://backbonejs.org/'},
  {name: 'AngularJS', url: 'https://angularjs.org/'},
  {name: 'jQuery', url: 'http://jquery.com/'},
  {name: 'Prototype', url: 'http://www.prototypejs.org/'},
  {name: 'React', url: 'http://facebook.github.io/react/'},
  {name: 'Ember', url: 'http://emberjs.com/'},
  {name: 'Knockout.js', url: 'http://knockoutjs.com/'},
  {name: 'Dojo', url: 'http://dojotoolkit.org/'},
  {name: 'Mootools', url: 'http://mootools.net/'},
  {name: 'Underscore', url: 'http://underscorejs.org/'},
  {name: 'Lodash', url: 'http://lodash.com/'},
  {name: 'Moment', url: 'http://momentjs.com/'},
  {name: 'Express', url: 'http://expressjs.com/'},
  {name: 'Koa', url: 'http://koajs.com/'}
]

# The redux prop getter.
stateProps = (state) ->
  query = state.query.trim().toLowerCase()
  libs = BEST_JS_LIBS
  if query.length
    libs = libs.filter (lib) -> lib.name.toLowerCase().match query

  query: state.query
  libs: libs

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
