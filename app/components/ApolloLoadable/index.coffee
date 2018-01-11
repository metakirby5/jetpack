# An apollo HOC with a spinner and error handling.

import {IS_DEV} from 'myconstants'
import {$} from 'myutil'

import Spinner from 'components/Spinner'
import ErrorMessage from 'components/ErrorMessage'

ApolloLoadable = ({data, loader}) ->
  if data.loading
    $ Spinner
  else if data.error
    $ ErrorMessage,
      if IS_DEV
        text: data.error.message
  else
    $ loader, data

export default ApolloLoadable
