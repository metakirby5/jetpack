# The base element of your app. Can be a router if you like.

{createElement: ce} = require 'react'

Example = require './components/Example'

module.exports = ->
  ce Example
