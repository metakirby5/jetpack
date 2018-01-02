# Main app frame.

import {$, load} from 'myutil'
import {Switch, Route} from 'react-router'
import {Link} from 'react-router-dom'
import {Helmet} from 'react-helmet'

import s from './style'

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
        $ Route, exact: true, path: '/', component: load ->
          `import(
            /* webpackChunkName: 'layouts/LibList' */
            'layouts/LibList')`
        $ Route, path: '*', component: load ->
          `import(
            /* webpackChunkName: 'layouts/NotFound' */
            'layouts/NotFound')`

export default App
