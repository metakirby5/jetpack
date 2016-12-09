# 404 page.

{div} = (require 'react').DOM
{errorContainer, errorCode} = require './style'

module.exports = ->
  div className: errorContainer,
    div className: errorCode,
      '404'
    'Not Found'
