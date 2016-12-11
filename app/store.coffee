# Configures the store.

{createStore, applyMiddleware} = require 'redux'
thunk = require 'redux-thunk'

reducers = require 'reducers'
{fetchLibs} = require 'actions/async'

store = createStore reducers,
  applyMiddleware thunk.default

# Dispatch an initial fetch.
store.dispatch fetchLibs()

# Set up hot reloading.
if module.hot
  module.hot.accept 'reducers', -> store.replaceReducer require 'reducers'

module.exports = store
