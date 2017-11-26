# The server definition.

path = require 'path'
express = require 'express'
morgan = require 'morgan'
proxy = require 'express-http-proxy'

config = require '../config'

INDEX = path.join config.dist, 'index.html'

server = express()

server
  # Logging
  .use morgan if config.isProd then 'common' else 'dev'

  # API
  .use config.api, require './api'

# Statically serve on prod
if config.isProd
  server
    .use '/', express.static config.dist
    .get '*', (req, res) ->
      res.sendFile INDEX
# Proxy to webpack server on dev
else
  server.use '/', proxy "localhost:#{config.ports.app}"

module.exports = server
