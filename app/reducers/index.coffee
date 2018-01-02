# The root reducer. You shouldn't touch this.

import {routerReducer} from 'react-router-redux'
import {autoReduce} from 'myutil'

# Require all reducers programatically.
export default autoReduce require.context('.', true, /^\.\/[^./]+$/),
  # Add vendor reducers.
  router: routerReducer
