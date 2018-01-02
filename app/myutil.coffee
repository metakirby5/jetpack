# Utility functions.
import {createElement} from 'react'
import {merge} from 'lodash'
import {combineReducers} from 'redux'
import Loadable from 'react-loadable'
import Spinner from 'react-spinkit'
import {Transition} from 'react-transition-group'
import st from 'styles/transition'
import s from './style'

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

MAKE_SPINNER = (props = {}) -> $ Spinner,
  merge props,
    name: 'double-bounce'

DEFAULT_SPINNER = (p) ->
  $.div className: s.spinnerContainer,
    if p.error
      $.div className: s.error,
        'Error!'
    else if p.timedOut
      [
        MAKE_SPINNER
          key: 0
          fadeIn: 'none'
        $ Transition,
          key: 1
          in: true
          appear: true
          timeout: 200
          (state) ->
            $.div
              className: [s.info, st.fade, st[state]].join ' '
              'Still loading...'
      ]
    else
      MAKE_SPINNER()

# Dynamically load a component.
export load =
  (loader, loading = DEFAULT_SPINNER) ->
    Loadable
      loader: loader
      loading: loading
      timeout: 5000
