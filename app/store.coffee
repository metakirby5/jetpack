# Configures the store.

{createStore, applyMiddleware} = require 'redux'
{browserHistory} = require 'react-router'
{routerMiddleware} = require 'react-router-redux'
{default: thunk} = require 'redux-thunk'

reducers = require 'reducers'
{fetchLibs} = require 'actions/async'

store = createStore reducers,
  applyMiddleware thunk, routerMiddleware browserHistory

# Dispatch an initial fetch.
store.dispatch fetchLibs()

# Set up hot reloading.
if module.hot
  module.hot.accept 'reducers', -> store.replaceReducer require 'reducers'

module.exports = store
