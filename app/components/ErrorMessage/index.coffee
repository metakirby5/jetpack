# A generic error message.

import {$} from 'myutil'

import s from './style'

ErrorMessage = ({text = 'Error!'}) ->
  $.div className: s.error,
    text

export default ErrorMessage
