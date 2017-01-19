# The main entry point. You shouldn't touch this.
require 'react-hot-loader/patch'

# Load vendor and global CSS.
require 'skeleton/css/normalize.css'
require 'skeleton/css/skeleton.css'
require 'styles'

{AppContainer} = require 'react-hot-loader'
{createElement: ce} = require 'react'
{render} = require 'react-dom'

# Render the root element.
root = document.getElementById 'react-root'
start = -> render (ce AppContainer, 0, ce require 'Root'), root
start()

# Set up hot reloading.
if module.hot
  module.hot.accept 'Root', start
