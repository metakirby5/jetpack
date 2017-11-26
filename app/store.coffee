# Configures the store.

{createStore, applyMiddleware} = require 'redux'
{browserHistory} = require 'react-router'
{routerMiddleware} = require 'react-router-redux'
{assignAll} = require 'redux-act'
{default: thunk} = require 'redux-thunk'

reducers = require 'reducers'
actions = require 'actions'

store = createStore reducers,
  applyMiddleware thunk, routerMiddleware browserHistory

# Mutatively bind all simple actions to the store.
assignAll actions, store

# Set up hot reloading.
if module.hot
  module.hot.accept 'reducers', -> store.replaceReducer require 'reducers'

module.exports = store
