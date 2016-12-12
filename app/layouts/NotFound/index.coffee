# 404 page.

{DOM: d} = require 'react'
s = require './style'

module.exports = ->
  d.main className: s.errorMain,
    d.header className: s.errorCode,
      '404'
    d.summary className: s.errorMessage,
      'not found'
