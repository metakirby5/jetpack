# 404 page.

{createElement: ce} = require 'react'
d = require 'react-dom-factories'

{Helmet} = require 'react-helmet'

s = require './style'

NotFoundLayout = ->
  d.main className: s.errorMain,
    ce Helmet, 0,
      d.title 0, '404'
    d.header className: s.errorCode,
      '404'
    d.summary className: s.errorMessage,
      'not found'

module.exports = NotFoundLayout
