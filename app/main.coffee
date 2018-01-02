# The main entry point. You shouldn't touch this.
require 'react-hot-loader/patch'

# Load vendor and global CSS.
require 'Skeleton/css/normalize.css'
require 'Skeleton/css/skeleton.css'
require 'styles'

{$} = require 'myutil'
{render} = require 'react-dom'
{AppContainer} = require 'react-hot-loader'

# Render the root element.
root = document.getElementById 'react-root'
start = -> render ($ AppContainer, 0, $ require 'Root'), root
start()

# Set up hot reloading.
if module.hot
  module.hot.accept 'Root', start
