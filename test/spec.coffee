# The root test file. You shouldn't touch this.

# Programatically require all tests.
spec = require.context '../src', true, /\.spec\.[^.]*$/
spec.keys().map spec
