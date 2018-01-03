# A Loadable HOC.

import {$} from 'myutil'
import Loadable from 'react-loadable'

import Spinner from 'components/Spinner'
import ErrorMessage from 'components/ErrorMessage'
import s from './style'

LoadingSpinner = (p) ->
  $.div className: s.spinnerContainer,
    if p.error
      $ ErrorMessage
    else
      $ Spinner

# Dynamically load a component.
MyLoadable = ({loader, loading = LoadingSpinner, timeout = 5000}) ->
  Loadable
    loader: loader
    loading: loading
    timeout: timeout

export default MyLoadable
