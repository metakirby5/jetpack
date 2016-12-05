# jetpack

Minimal, from-scratch webpack boilerplate with:
  - Pug
  - Coffeescript
  - Coffeelint
  - Stylus
  - Nib
  - Stylint
  - React
  - Redux
  - Skeleton CSS
  - Source maps + React Hot Loader 3.0 beta 3 for development
  - Deduplication + minification for production

# Usage

You may (and probably should) substitute `npm` with `yarn`.

- To install dependencies: `npm install && bower install`
- To start `webpack-dev-server`: `npm start`
- To build deduplicated, minified html/scripts into `dist/`: `npm run build`

# Conventions

- All React components are pure functional components with Redux.
- The entry point is `main.coffee`, which also sets up hot reloading.
- The root component used for routing, etc. can be found at `Root.coffee`.
- Each subcomponent gets a folder in `components/` with the following
  structure:
  - `index.coffee`: Exports a Redux-connected component.
  - `style.l.styl`: Locally scoped styles for the component.
- The store can be found at `store.coffee`, and the root reducer at
  `reducers/index.coffee`.
- Each reducer gets a file in `reducers/`, and is automatically imported.
  It manages the state sub-tree matching its filename, sans extension.
- Action types can be found at `actions/types.coffee`.
- Each action category gets a file  in `actions/`, and exports an object keyed
  by action creator name.
