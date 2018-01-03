# Utility functions.
import {createElement, Fragment} from 'react'
import {merge, head, tail} from 'lodash'
import {combineReducers} from 'redux'

# Reducer boilerplate for Object.assign.
export assign = (transform = (state, payload) -> payload) ->
  (state, payload) -> merge state, (transform state, payload)

# Programatically require reducers in the current directory.
export autoReduce = (ctx, additional = {}) ->
  combineReducers ctx.keys().reduce ((a, n) ->
    if n isnt './index'
      a[n.slice 2] = (ctx n)['default']
    a
  ), additional

# Wrapper around React.createElement.
# $.div args... -> React.createElement('div', args...)
# $ $, args... -> React.createElement(React.Fragment, 0, args...)
# $ Element, args... -> React.createElement(Element, args...)
export $ = new Proxy createElement,
  get: (target, prop) -> (args...) -> target prop, args...
  apply: (target, that, args) ->
    if $ is head args
      target Fragment, 0, (tail args)...
    else
      target args...
