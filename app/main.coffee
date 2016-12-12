# The main entry point. You shouldn't touch this.
require 'react-hot-loader/patch'

# Load vendor and global CSS.
require 'skeleton/css/normalize.css'
require 'skeleton/css/skeleton.css'
require 'styles'

{AppContainer} = require 'react-hot-loader'
{createElement: ce} = require 'react'
{render} = require 'react-dom'
{Provider} = require 'react-redux'

store = require 'store'

# Render the root element.
root = document.getElementById 'react-root'
start = (app) -> render (
  ce AppContainer, null,
    ce Provider, store: store,
      ce app
), root
start require 'Root'

# Set up hot reloading.
if module.hot
  module.hot.accept 'Root', -> start require 'Root'
