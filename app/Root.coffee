# The base element. In this case, it is a Redux provider + router.

{createElement: ce} = require 'react'
{Provider} = require 'react-redux'
{Router, Route, browserHistory} = require 'react-router'
{syncHistoryWithStore} = require 'react-router-redux'

store = require 'store'
App = require 'layouts/App'
LibList = require 'layouts/LibList'
NotFound = require 'layouts/NotFound'

history = syncHistoryWithStore browserHistory, store

module.exports = ->
  ce Provider, store: store,
    ce Router, history: history,
      ce Route, component: App,
        ce Route, path: '/', component: LibList
        ce Route, path: '*', component: NotFound
