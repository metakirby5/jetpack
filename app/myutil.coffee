# Utility functions.
{merge} = require 'lodash'
{combineReducers} = require 'redux'

module.exports =
  # Reducer boilerplate for Object.assign.
  assign: (transform = (state, payload) -> payload) ->
    (state, payload) -> merge state, (transform state, payload)

  # Programatically require reducers in the current directory.
  autoReduce: (ctx, additional = {}) ->
    combineReducers ctx.keys().reduce ((a, n) ->
      if n isnt './index'
        a[n.slice 2] = ctx n
      a
    ), additional
