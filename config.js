// App configuration
const path = require('path');

module.exports = {
  env: process.env.npm_lifecycle_event,
  isProd: process.env.npm_lifecycle_event === 'start',
  app: path.join(__dirname, 'app'),
  server: path.join(__dirname, 'server'),
  dist: path.join(__dirname, 'dist'),
  test: path.join(__dirname, 'test'),
  api: '/api',
  ports: {
    app: 8080,
    server: 3000,
  },
};
