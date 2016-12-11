# 404 page.

{main, header, summary} = (require 'react').DOM
{errorMain, errorCode, errorMessage} = require './style'

module.exports = ->
  main className: errorMain,
    header className: errorCode,
      '404'
    summary className: errorMessage,
      'not found'
