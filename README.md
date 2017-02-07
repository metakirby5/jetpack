# jetpack

Minimal, opinionated, from-scratch webpack boilerplate with:
  - Express
  - Coffeescript + Coffeelint
  - React + react-router
  - Redux + redux-act + reselect
  - Mocha + Chai
  - Stylus + Nib + Stylint
  - Skeleton CSS
  - Pug
  - Source maps + React Hot Loader 3.0 beta 3 for development
  - Deduplication + minification for production

Example from http://gaearon.github.io/react-hot-loader/.

# Usage

You may (and probably should) substitute `npm` with `yarn`.

- To install dependencies: `npm install && bower install`
- To start serving for production: `npm start` (be sure to build first!)
- To run the dev servers: `npm run dev`
  - The main server is at `localhost:3000`, which proxies everything but
    `/api` to `webpack-dev-server` at `localhost:8080`
- To test: `npm test`, `npm run test:watch`, or `npm run test:browser`
- To build deduplicated, minified html/scripts into `dist/`: `npm run build`

The webpack configuration is generated based on `npm_lifecycle_event`, so
running the scripts from `package.json` directly will not yield the correct
results.

# App conventions

All files are in `app/` unless otherwise noted.

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
- Actions are created and handled using redux-act.
  - Actions can be found at `actions/index.coffee`.
  - Async actions can be found at `actions/async.coffee.`
- Tests are considered any file within the `app` tree ending with `.spec.*`,
  where `*` is any extension (e.g. `coffee`). These are all automatically
  picked up by `npm test`.

# Server conventions

Probably will be GraphQL, TBD.
