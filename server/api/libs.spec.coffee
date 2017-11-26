# A test suite for lib selectors.

require('chai').should()
libs = require './libs'

describe 'server', -> describe 'libs', ->
  describe '#Query#libs', ->
    it 'should have Backbone.js', (done) ->
      libs.Query.libs().should.deep.include
        name: 'Backbone.js'
        url: 'http://backbonejs.org/'
      done()
