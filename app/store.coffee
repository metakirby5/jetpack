# Configures the store.

import {createStore, applyMiddleware, compose} from 'redux'
import {routerMiddleware} from 'react-router-redux'
import {assignAll} from 'redux-act'
import thunk from 'redux-thunk'

import reducers from 'reducers'
import actions from 'actions'
import history from 'myhistory'

# Activate dev tools.
doCompose = if process.env.NODE_ENV is 'development'
  window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ ? compose
else compose

store = createStore reducers, doCompose applyMiddleware(
  thunk
  routerMiddleware history
)

# Mutatively bind all simple actions to the store.
assignAll actions, store

# Set up hot reloading.
if module.hot
  module.hot.accept 'reducers', -> store.replaceReducer reducers

export default store
