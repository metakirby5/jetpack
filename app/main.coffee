# The main entry point. You shouldn't touch this.
import 'react-hot-loader/patch'

# Load vendor and global CSS.
import 'Skeleton/css/normalize.css'
import 'Skeleton/css/skeleton.css'
import 'styles'

import {$} from 'myutil'
import {render} from 'react-dom'
import {AppContainer} from 'react-hot-loader'
import Root from 'Root'

# Render the root element.
root = document.getElementById 'react-root'
start = -> render ($ AppContainer, 0, $ Root), root
start()

# Set up hot reloading.
if module.hot
  module.hot.accept 'Root', start
