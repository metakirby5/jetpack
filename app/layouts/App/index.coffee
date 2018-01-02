# Main app frame.

{$} = require 'myutil'
{Switch, Route} = require 'react-router'
{Link} = require 'react-router-dom'
{Helmet} = require 'react-helmet'

s = require './style'
LibList = require 'layouts/LibList'
NotFound = require 'layouts/NotFound'

App = ->
  $.div 0,
    $ Helmet, 0,
      $.meta
        charSet: 'utf-8'
      $.meta
        name: 'viewport'
        content: 'width=device-width'
        initialScale: 1
      $.title 0, 'jetpack'

    $.main className: s.content,
      $.nav className: s.navbar,
        $.aside className: s.brand,
          $ Link, to: '/', 'jetpack'
        $.ul className: s.navMenu,
          $.li 0,
            $ Link, to: '/404', '404 link'
      $ Switch, 0,
        $ Route, exact: true, path: '/', component: LibList
        $ Route, path: '*', component: NotFound

module.exports = App
