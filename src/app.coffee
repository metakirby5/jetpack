# The base element of your app. Can be a router if you like.

React = require 'react'
Example = require './components/example'

module.exports = React.createClass
  render: ->
    return React.createElement Example
