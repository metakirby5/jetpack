# A generic error message.

import {$} from 'myutil'

import s from './style'

ErrorMessage = ({text = 'Error!'}) ->
  $.div className: s.error,
    'Error!'

export default ErrorMessage
