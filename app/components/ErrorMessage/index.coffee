# A generic error message.

import {IS_DEV} from 'myconstants'
import {$} from 'myutil'

import s from './style'

ErrorMessage = ({text = 'Error!', devText}) ->
  if IS_DEV
    displayText = devText ? text

  $.div className: s.error,
    displayText

export default ErrorMessage
