# Asynchronous actions.

{API} = require 'constants'
actions = require 'actions'

module.exports =
  fetchLibs: -> (dispatch) ->
    dispatch actions.requestLibs()
    fetch "#{API}/libs"
      .then (r) -> r.json()
      .then (libs) -> dispatch actions.receiveLibs libs
      .catch (e) -> dispatch actions.errorLibs()
