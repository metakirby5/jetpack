# The root reducer. You shouldn't touch this.

{routerReducer} = require 'react-router-redux'
{autoReduce} = require 'myutil'

# Require all reducers programatically.
module.exports = autoReduce require.context('.', true, /^\.\/[^./]+$/),
  # Add vendor reducers.
  router: routerReducer
