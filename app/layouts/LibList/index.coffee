# The page layout for LibList.

{$} = require 'myutil'

s = require './style'
LibList = require 'components/LibList'

LibListLayout = ->
  $.div className: s.container,
    'Here is the library list.'
    $.div className: s.main,
      $ LibList

module.exports = LibListLayout
