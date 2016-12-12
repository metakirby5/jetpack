# The base element. In this case, it is a router.

{createElement: ce} = require 'react'
{Router, Route, browserHistory} = require 'react-router'
{syncHistoryWithStore} = require 'react-router-redux'

store = require 'store'
App = require 'layouts/App'
LibList = require 'layouts/LibList'
NotFound = require 'layouts/NotFound'

history = syncHistoryWithStore browserHistory, store

module.exports = ->
  ce Router, history: history,
    ce Route, component: App,
      ce Route, path: '/', component: LibList
      ce Route, path: '*', component: NotFound
