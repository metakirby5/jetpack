# Reducer for query.

import {createReducer} from 'redux-act'
import a from 'actions'

export default createReducer (act) ->
  act a.queryChange, (state, payload) -> payload
, ''
