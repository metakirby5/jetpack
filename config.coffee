# App configuration
path = require 'path'

dir = (name) -> path.join __dirname, name

module.exports =
  env: process.env.npm_lifecycle_event
  isProd: process.env.npm_lifecycle_event is 'start'
  app: dir 'app'
  server: dir 'server'
  schema: dir 'schema'
  dist: dir 'dist'
  test: dir 'test'
  api: '/api'
  ports:
    app: 8080
    server: 3000
