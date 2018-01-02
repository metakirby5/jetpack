# 404 page.

{$} = require 'myutil'

{Helmet} = require 'react-helmet'

s = require './style'

NotFoundLayout = ->
  $.main className: s.errorMain,
    $ Helmet, 0,
      $.title 0, '404'
    $.header className: s.errorCode,
      '404'
    $.summary className: s.errorMessage,
      'not found'

module.exports = NotFoundLayout
