{createStore} = require 'redux'
reducers = require './reducers'

store = createStore reducers

if module.hot
  module.hot.accept './reducers', -> store.replaceReducer require './reducers'

module.exports = store
