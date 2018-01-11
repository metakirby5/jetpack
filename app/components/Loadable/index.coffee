# A Loadable HOC.

import {$} from 'myutil'
import Loadable from 'react-loadable'

import Spinner from 'components/Spinner'
import ErrorMessage from 'components/ErrorMessage'
import s from './style'

LoadingSpinner = ({error}) ->
  $.div className: s.spinnerContainer,
    if error
      $ ErrorMessage,
        devText: error.message
    else
      $ Spinner

# Dynamically load a component.
MyLoadable = ({loader, loading = LoadingSpinner, timeout = 5000}) ->
  Loadable
    loader: loader
    loading: loading
    timeout: timeout

export default MyLoadable
