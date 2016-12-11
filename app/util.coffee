# Utility functions.

module.exports =
  # Reducer boilerplate for Object.assign.
  assign: (mapper = (payload) -> payload) ->
    (state, payload) -> Object.assign {}, state, mapper payload
