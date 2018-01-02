# A test suite for lib selectors.

import {should} from 'chai'
import {filteredByQuery} from './libs'

should()

LIBS = [
  {name: 'a'}
  {name: 'b'}
  {name: 'B'}
  {name: 'c'}
  {name: 'cool'}
]

withQuery = (query) -> {query, data: {libs: LIBS}}

describe 'app', -> describe 'libs', ->
  describe '#filteredByQuery', ->
    it 'should filter to a single result', (done) ->
      (filteredByQuery withQuery 'a').should.deep.equal [
        {name: 'a'}
      ]
      done()
    it 'should be case insensitive', (done) ->
      (filteredByQuery withQuery 'b').should.deep.equal [
        {name: 'b'}
        {name: 'B'}
      ]
      (filteredByQuery withQuery 'B').should.deep.equal [
        {name: 'b'}
        {name: 'B'}
      ]
      done()
    it 'should do prefix matching', (done) ->
      (filteredByQuery withQuery 'c').should.deep.equal [
        {name: 'c'}
        {name: 'cool'}
      ]
      done()
