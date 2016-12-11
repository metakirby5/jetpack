# A test suite for lib selectors.

(require 'chai').should()
libs = require './libs'

LIBS = [
  {name: 'a'}
  {name: 'b'}
  {name: 'B'}
  {name: 'c'}
  {name: 'cool'}
]

withQuery = (query) -> {query, libs: {items: LIBS}}

describe 'libs', ->
  describe '#filteredByQuery', ->
    it 'should filter to a single result', (done) ->
      (libs.filteredByQuery withQuery 'a').should.deep.equal [
        {name: 'a'}
      ]
      done()
    it 'should be case insensitive', (done) ->
      (libs.filteredByQuery withQuery 'b').should.deep.equal [
        {name: 'b'}
        {name: 'B'}
      ]
      (libs.filteredByQuery withQuery 'B').should.deep.equal [
        {name: 'b'}
        {name: 'B'}
      ]
      done()
    it 'should do prefix matching', (done) ->
      (libs.filteredByQuery withQuery 'c').should.deep.equal [
        {name: 'c'}
        {name: 'cool'}
      ]
      done()
