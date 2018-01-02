# Simple actions.

import {fromPairs} from 'lodash'
import {createAction} from 'redux-act'

# Generate action map.
export default fromPairs [
  'queryChange'
].map (action) -> [action, createAction action]
