# Main app frame.

{createElement: ce, DOM} = require 'react'
{main, nav, aside, ul, li, a} = DOM
{Link} = require 'react-router'

s = require './style'

module.exports = ({children}) ->
  main className: s.content,
    nav className: s.navbar,
      aside className: s.brand, 'jetpack'
      ul className: s.navMenu,
        li null, ce Link, to: '/404', '404 link'
    children
