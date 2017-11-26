# The GraphQL API creator. You shouldn't touch this.

path = require 'path'
{readdirSync, readFileSync} = require 'fs'
{filter, zip, merge} = require 'lodash'
{makeExecutableSchema} = require 'graphql-tools'

curdir = (args...) -> path.resolve __dirname, args...

# Get API files.
apis = readdirSync __dirname
  .filter((s) -> s.endsWith('.gql'))
  .map((s) -> s.slice 0, -4)

# Programmatically create API.
[schemas, resolvers] = zip(apis.map((k) -> [
  readFileSync (curdir "#{k}.gql"), "UTF8"
  require curdir "#{k}.coffee"
])...)

module.exports = makeExecutableSchema
  typeDefs: schemas
  resolvers: merge(resolvers...)
