# Reducer for libs.

{createReducer} = require 'redux-act'

{requestLibs, receiveLibs, errorLibs} = require 'actions'
{assign} = require 'util'

module.exports = createReducer (act) ->
  act requestLibs, assign ->
    status: 'loading...'
  act receiveLibs, assign (state, payload) ->
    status: null
    items: payload
  act errorLibs, assign (state, payload) ->
    status: 'unable to fetch!'
,
  status: 'loading...'
  items: []
