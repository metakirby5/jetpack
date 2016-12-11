# The root app test file. You shouldn't touch this.

# Programatically require all tests.
spec = require.context '../app', true, /\.spec\.[^.]*$/
spec.keys().map spec
