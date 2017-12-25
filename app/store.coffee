# Configures the store.

{createStore, applyMiddleware, compose} = require 'redux'
{routerMiddleware} = require 'react-router-redux'
{assignAll} = require 'redux-act'
{default: thunk} = require 'redux-thunk'

reducers = require 'reducers'
actions = require 'actions'
history = require 'myhistory'

# Activate dev tools.
if process.env.NODE_ENV is 'development'
  compose = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ ? compose

store = createStore reducers, compose applyMiddleware(
  thunk
  routerMiddleware history
)

# Mutatively bind all simple actions to the store.
assignAll actions, store

# Set up hot reloading.
if module.hot
  module.hot.accept 'reducers', -> store.replaceReducer require 'reducers'

module.exports = store
