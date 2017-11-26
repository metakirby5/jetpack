# Utility functions.

module.exports =
  # Reducer boilerplate for Object.assign.
  assign: (transform = (state, payload) -> payload) ->
    (state, payload) -> Object.assign {}, state, transform state, payload
