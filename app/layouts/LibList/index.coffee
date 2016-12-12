# The page layout for LibList.

{createElement: ce, DOM} = require 'react'
{div} = DOM

s = require './style'
LibList = require 'components/LibList'

module.exports = ->
  div className: s.container,
    'Here is the library list.'
    div className: s.main,
      ce LibList
