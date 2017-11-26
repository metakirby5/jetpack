# Utility functions.
{merge} = require 'lodash'

module.exports =
  # Reducer boilerplate for Object.assign.
  assign: (transform = (state, payload) -> payload) ->
    (state, payload) -> merge state, (transform state, payload)
