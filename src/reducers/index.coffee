# The root reducer. You shouldn't touch this.

{combineReducers} = require 'redux'

# Require all reducers programatically.
reducerReq = require.context '.', false, /^\.\/[^.]*$/
module.exports = combineReducers reducerReq.keys().reduce ((a, n) ->
  a[n.slice 2] = reducerReq n if n != './index'
  a
), {}
