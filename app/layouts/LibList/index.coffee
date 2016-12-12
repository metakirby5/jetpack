# The page layout for LibList.

{createElement: ce, DOM: d} = require 'react'

s = require './style'
LibList = require 'components/LibList'

module.exports = ->
  d.div className: s.container,
    'Here is the library list.'
    d.div className: s.main,
      ce LibList
