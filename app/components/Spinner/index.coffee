# A default spinner.

import Spinner from 'react-spinkit'
import {$, merge} from 'myutil'

MySpinner = (p) ->
  $ Spinner,
    merge p,
      name: 'double-bounce'

export default MySpinner
