# jetpack

Minimal, opinionated, from-scratch webpack boilerplate with:
  - Express
  - Coffeescript + Coffeelint
  - React + react-router + react-helmet
  - Redux + redux-act + reselect
  - GraphQL + Apollo
  - Mocha + Chai
  - Stylus + Nib + Stylint
  - Skeleton CSS
  - Pug
  - Source maps + React Hot Loader for development
  - Deduplication + minification for production
  - Probably some other goodies I forgot

Example adapted from http://gaearon.github.io/react-hot-loader/.

# Usage

- To install dependencies: `yarn`
- To start serving for production: `yarn start` (be sure to build first!)
- To run the dev servers: `yarn dev`
  - The main server is at `localhost:3000`, which proxies everything but
    `/api` to `webpack-dev-server` at `localhost:8080`
- To analyze the bundle: `yarn analyze`
  - The production bundle is analyzed with `webpack-bundle-analyzer`.
- To test: `yarn test`, `yarn test:watch`, or `yarn test:browser`
  - Note: `yarn test:browser` will only pick up tests in `app/`.
- To build deduplicated, minified html/scripts into `dist/`: `yarn build`

The webpack configuration is generated based on `npm_lifecycle_event`, so
running the scripts from `package.json` directly will not yield the correct
results.

# App conventions

All files are in `app/` unless otherwise noted.

- Only use ES6 import/export, not `require`, to allow tree-shaking.
  - The exception is `require.context` for dynamic utils.
- All React components are pure functional components with Redux and Apollo.
- The entry point is `main.coffee`, which also sets up hot reloading.
- The root component used for routing, etc. can be found at `Root.coffee`.
- Each subcomponent gets a folder in `components/` with the following
  structure:
  - `index.coffee`: Exports a Redux-connected component.
  - `style.l.styl`: Locally scoped styles for the component.
- The store can be found at `store.coffee`, and the root reducer at
  `reducers/index.coffee`. The actions are bound to this store.
- Each reducer gets a file in `reducers/`, and is automatically imported.
  It manages the state sub-tree matching its filename, sans extension.
- Actions are created and handled using redux-act.
  - Simple actions can be found at `actions/index.coffee`.
  - Apollo should be used to handle GraphQL queries.
  - Asynchronous actions may go in `actions/async.coffee`.
- Selectors are created automatically based on the reducers in `reducers/`.
  - Complex selectors should be created with reselect, using the `sqgl`
    GraphQL-selector-factory when GraphQL data is needed.
- Tests are considered any file within the `app` tree ending with `.spec.*`,
  where `*` is any extension (e.g. `coffee`). These are all automatically
  picked up by `yarn test`, `yarn test:watch`, and `yarn test:browser`.

# Server conventions

- Only use `require`, not ES6 import/export, since `node` doesn't support it
  yet.
- GraphQL things go in `graphql/`.
  - Schemas go in `schema/`.
  - Queries go in `query/`.
- Main server code goes in `server/`.
  - The entry point is `index.coffee`, and it hooks up the API and the app.
  - The API can be found under `API/`.
    - `index.coffee` here automatically creates an API based on the
      definitions in the schema folder. It `require`s the corresponding
      `.coffee` file in the API folder.
- Tests are considered any file within the `server` tree ending with `.spec.*`,
  where `*` is any extension (e.g. `coffee`). These are all automatically
  picked up by `yarn test` and `yarn test:watch`, but *not* `yarn test:browser`.
