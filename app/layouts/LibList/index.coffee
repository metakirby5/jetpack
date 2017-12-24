# The page layout for LibList.

{createElement: ce} = require 'react'
d = require 'react-dom-factories'

s = require './style'
LibList = require 'components/LibList'

LibListLayout = ->
  d.div className: s.container,
    'Here is the library list.'
    d.div className: s.main,
      ce LibList

module.exports = LibListLayout
