require './main.styl'

React = require 'react'
{render} = require 'react-dom'
{h1} = React.DOM

render (h1 null, 'Hello world'), document.getElementById 'root'
