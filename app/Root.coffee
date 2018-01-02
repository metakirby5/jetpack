# The base element. In this case, it is a Redux provider + router.

import {$} from 'myutil'
import {Provider} from 'react-redux'
import {Router, Route} from 'react-router'
import {ConnectedRouter} from 'react-router-redux'

import {ApolloProvider} from 'react-apollo'
import {ApolloClient} from 'apollo-client'
import {HttpLink} from 'apollo-link-http'
import {InMemoryCache} from 'apollo-cache-inmemory'

import {API} from 'myconstants'
import store from 'store'
import history from 'myhistory'

import App from 'layouts/App'

client = new ApolloClient
  link: new HttpLink
    uri: API
  cache: new InMemoryCache()

Root = ->
  $ Provider, {store},
    $ ApolloProvider, {client},
      $ ConnectedRouter, {history},
        $ Route, component: App

export default Root
