# The base element. In this case, it is a Redux provider + router.

{createElement: ce} = require 'react'

{Provider} = require 'react-redux'
{Router, Route, browserHistory} = require 'react-router'
{syncHistoryWithStore} = require 'react-router-redux'

{ApolloProvider} = require 'react-apollo'
{ApolloClient} = require 'apollo-client'
{HttpLink} = require 'apollo-link-http'
{InMemoryCache} = require 'apollo-cache-inmemory'

{API} = require 'myconstants'
store = require 'store'
App = require 'layouts/App'
LibList = require 'layouts/LibList'
NotFound = require 'layouts/NotFound'

history = syncHistoryWithStore browserHistory, store
client = new ApolloClient
  link: new HttpLink
    uri: API
  cache: new InMemoryCache()

module.exports = ->
  ce Provider, {store},
    ce ApolloProvider, {client},
      ce Router, {history},
        ce Route, component: App,
          ce Route, path: '/', component: LibList
          ce Route, path: '*', component: NotFound
