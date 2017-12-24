# 404 page.

d = require 'react-dom-factories'

s = require './style'

NotFoundLayout = ->
  d.main className: s.errorMain,
    d.header className: s.errorCode,
      '404'
    d.summary className: s.errorMessage,
      'not found'

module.exports = NotFoundLayout
