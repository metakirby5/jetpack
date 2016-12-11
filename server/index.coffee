# The server definition.

path = require 'path'
express = require 'express'
cors = require 'cors'
morgan = require 'morgan'
bodyParser = require 'body-parser'

PROD = process.env.NODE_ENV == 'production'
DIST = path.join __dirname, '..', 'dist'
INDEX = path.join DIST, 'index.html'

app = express()

# Use cors on dev
if !PROD
  app.use cors()

app
  # Logging
  .use morgan if PROD then 'common' else 'dev'

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
