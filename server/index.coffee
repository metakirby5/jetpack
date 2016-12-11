# The server definition.

path = require 'path'
express = require 'express'

app = express()

# Statically serve the app
app.use '/', express.static path.join __dirname, '..', 'dist'

module.exports = app
