# The server definition.

path = require 'path'
express = require 'express'
cors = require 'cors'
bodyParser = require 'body-parser'

DIST = path.join __dirname, '..', 'dist'
INDEX = path.join DIST, 'index.html'

app = express()

# Use cors on dev
if process.env.NODE_ENV != 'production'
  app.use cors()

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
