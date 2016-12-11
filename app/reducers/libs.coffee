# Reducer for libs.

{createReducer} = require 'redux-act'

{requestLibs, receiveLibs, errorLibs} = require 'actions'
{assign} = require 'util'

module.exports = createReducer (act) ->
  act requestLibs, assign ->
    status: 'loading...'
  act receiveLibs, assign (libs) ->
    status: ''
    items: libs
  act errorLibs, assign (libs) ->
    status: 'unable to fetch!'
,
  status: 'loading...'
  items: []
