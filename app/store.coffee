# Configures the store. You shouldn't touch this.

{createStore} = require 'redux'

reducers = require 'reducers'

store = createStore reducers

# Set up hot reloading.
if module.hot
  module.hot.accept 'reducers', -> store.replaceReducer require 'reducers'

module.exports = store
