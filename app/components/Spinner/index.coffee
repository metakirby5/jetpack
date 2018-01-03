# A default spinner.

import {merge} from 'lodash'
import Spinner from 'react-spinkit'
import {$} from 'myutil'

MySpinner = (p) ->
  $ Spinner,
    merge p,
      name: 'double-bounce'

export default MySpinner
