# The base element. In this case, it is a Redux provider + router.

{$} = require 'myutil'
{Provider} = require 'react-redux'
{Router, Route} = require 'react-router'
{ConnectedRouter} = require 'react-router-redux'

{ApolloProvider} = require 'react-apollo'
{ApolloClient} = require 'apollo-client'
{HttpLink} = require 'apollo-link-http'
{InMemoryCache} = require 'apollo-cache-inmemory'

{API} = require 'myconstants'
store = require 'store'
history = require 'myhistory'

App = require 'layouts/App'

client = new ApolloClient
  link: new HttpLink
    uri: API
  cache: new InMemoryCache()

Root = ->
  $ Provider, {store},
    $ ApolloProvider, {client},
      $ ConnectedRouter, {history},
        $ Route, component: App

module.exports = Root
