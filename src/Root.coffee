# The base element of your app. Can be a router if you like.

{createElement: ce} = require 'react'
{Router, Route, browserHistory} = require 'react-router'
{syncHistoryWithStore} = require 'react-router-redux'

store = require 'store'
Example = require 'components/Example'
NotFound = require 'components/NotFound'

history = syncHistoryWithStore browserHistory, store

module.exports = ->
  ce Router, history: history,
    ce Route, path: '/', component: Example
    ce Route, path: '*', component: NotFound
