# The base element of your app. Can be a router if you like.

{Component, createElement} = require 'react'
Example = require './components/Example'

module.exports = class extends Component
  render: -> createElement Example
