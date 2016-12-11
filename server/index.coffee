# The server definition.

path = require 'path'
express = require 'express'
bodyParser = require 'body-parser'

DIST = path.join __dirname, '..', 'dist'
INDEX = path.join DIST, 'index.html'

app = express()

app
  # POST data
  .use bodyParser.json()

  # API
  .use '/api', require './api'

  # Statically serve the app
  .use '/', express.static DIST

  # Fall back on app index
  .get '*', (req, res) ->
    res.sendFile INDEX

module.exports = app
