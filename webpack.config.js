'use strict';

var path = require('path')
  , webpack = require('webpack');

var SRC_PATH = path.join(__dirname, 'src')
  , BUILD_PATH = path.join(__dirname, 'static');

var config = {
  // What file to start at
  entry: [
    path.join(SRC_PATH, 'main.coffee'),
  ],

  // Where to output
  output: {
    path: BUILD_PATH,
    publicPath: '/static/',
    filename: 'main.js',
  },

  module: {
    // What to load
    loaders: [
      { // Coffeescript
        test: /\.coffee$/,
        loaders: ['coffee'],
      },
      { // Stylus
        test: /\.styl$/,
        exclude: /\.u\.styl/,
        loader: 'style!css!stylus',
      },
      { // Reference-counted stylus
        test: /\.u\.styl/,
        loader: 'style/useable!css!stylus',
      },
      { // Plain CSS
        test: /\.css$/,
        loader: 'style!css',
      },
    ]
  }
};

// Development
if (process.env.NODE_ENV !== 'production') {
  // Source maps
  config.devtool = 'eval';

  // Hot reloading
  config.plugins = [new webpack.HotModuleReplacementPlugin()];
  config.entry.unshift(
    'webpack/hot/dev-server',
    'webpack-dev-server/client?http://0.0.0.0:3000'
  );
  config.module.loaders[0].loaders.unshift('react-hot-loader/webpack');
}

module.exports = config;
