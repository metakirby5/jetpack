# 404 page.

import {$} from 'myutil'
import {Helmet} from 'react-helmet'

import s from './style'

NotFoundLayout = ->
  $.main className: s.errorMain,
    $ Helmet, 0,
      $.title 0, '404'
    $.header className: s.errorCode,
      '404'
    $.summary className: s.errorMessage,
      'not found'

export default NotFoundLayout
