# Main app frame.

{createElement: ce} = require 'react'
d = require 'react-dom-factories'
{Switch, Route} = require 'react-router'
{Link} = require 'react-router-dom'
{Helmet} = require 'react-helmet'

s = require './style'
LibList = require 'layouts/LibList'
NotFound = require 'layouts/NotFound'

App = ->
  d.div 0,
    ce Helmet, 0,
      d.meta
        charSet: 'utf-8'
      d.meta
        name: 'viewport'
        content: 'width=device-width'
        initialScale: 1
      d.title 0, 'jetpack'

    d.main className: s.content,
      d.nav className: s.navbar,
        d.aside className: s.brand,
          ce Link, to: '/', 'jetpack'
        d.ul className: s.navMenu,
          d.li 0,
            ce Link, to: '/404', '404 link'
      ce Switch, 0,
        ce Route, exact: true, path: '/', component: LibList
        ce Route, path: '*', component: NotFound

module.exports = App
