# The page layout for LibList.

import {$} from 'myutil'

import s from './style'
import LibList from 'components/LibList'

LibListLayout = ->
  $.div className: s.container,
    'Here is the library list.'
    $ LibList

export default LibListLayout
