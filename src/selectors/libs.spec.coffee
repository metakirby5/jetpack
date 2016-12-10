{deepEqual} = require 'assert'
libs = require './libs'

LIBS = [
  {name: 'a'},
  {name: 'b'},
  {name: 'B'},
  {name: 'c'},
  {name: 'cool'},
]

withQuery = (query) -> {query, libs: LIBS}

describe 'libs', ->
  describe '#filteredByQuery', ->
    it 'should filter to a single result', (done) ->
      deepEqual (libs.filteredByQuery withQuery 'a'), [
        {name: 'a'},
      ]
      done()
    it 'should be case insensitive', (done) ->
      deepEqual (libs.filteredByQuery withQuery 'b'), [
        {name: 'b'},
        {name: 'B'},
      ]
      deepEqual (libs.filteredByQuery withQuery 'B'), [
        {name: 'b'},
        {name: 'B'},
      ]
      done()
    it 'should do prefix matching', (done) ->
      deepEqual (libs.filteredByQuery withQuery 'c'), [
        {name: 'c'},
        {name: 'cool'},
      ]
      done()
