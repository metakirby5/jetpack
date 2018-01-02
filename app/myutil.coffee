# Utility functions.
import {createElement} from 'react'
import {merge} from 'lodash'
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
# $ Element, args... -> React.createElement(Element, args...)
export $ = new Proxy createElement,
  get: (target, prop) -> (args...) -> createElement prop, args...