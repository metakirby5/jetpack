# The base element of your app. Can be a router if you like.

{createClass, createElement} = require 'react'
Example = require './components/example'

module.exports = createClass
  render: -> createElement Example
