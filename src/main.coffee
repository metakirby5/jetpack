# The entry point. You shouldn't touch this.

# Load vendor and global CSS.
require 'skeleton/css/normalize.css'
require 'skeleton/css/skeleton.css'
require './style'

React = require 'react'
{render} = require 'react-dom'
App = require './app'

# Render the root element.
render (React.createElement App), document.getElementById 'react-root'
