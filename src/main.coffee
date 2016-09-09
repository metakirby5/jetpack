require 'skeleton/css/normalize.css'
require 'skeleton/css/skeleton.css'
require './style'

React = require 'react'
{render} = require 'react-dom'
App = require './app'

render (React.createElement App), document.getElementById 'react-root'
