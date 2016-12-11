# API routing.

{Router} = require 'express'

api = Router()

api
  .use '/libs', require './libs'

module.exports = api
