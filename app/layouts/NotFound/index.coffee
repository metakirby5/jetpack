# 404 page.

{main, header, summary} = (require 'react').DOM
s = require './style'

module.exports = ->
  main className: s.errorMain,
    header className: s.errorCode,
      '404'
    summary className: s.errorMessage,
      'not found'
