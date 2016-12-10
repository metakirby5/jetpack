# Add source maps.
require 'source-map-support/register'

# Programatically require all tests.
spec = require.context '../src', true, /\.spec\.[^.]*$/
spec.keys().map spec
