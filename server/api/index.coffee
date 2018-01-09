# The GraphQL API creator. You shouldn't touch this.

path = require 'path'
{readdirSync, readFileSync} = require 'fs'
{filter, zip, merge} = require 'lodash'
{makeExecutableSchema} = require 'graphql-tools'
{mergeTypes} = require 'merge-graphql-schemas'

config = require '../../config'

schemadir = (args...) -> path.join config.schema, args...

# Get API files.
apis = readdirSync schemadir()
  .filter (s) -> s.endsWith('.gql')
  .map (s) -> s.slice 0, -4

# Programmatically create API.
[schemas, resolvers] = zip apis.map((k) -> [
  readFileSync (schemadir "#{k}.gql"), 'UTF8'
  require "./#{k}"
])...

module.exports = makeExecutableSchema
  typeDefs: mergeTypes schemas
  resolvers: merge resolvers...
