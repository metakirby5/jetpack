'use strict';

var path = require('path')
  , webpack = require('webpack');

const SRC_PATH = path.join(__dirname, 'src')
    , BUILD_PATH = path.join(__dirname, 'static');

const isVendor = (module) => {
  var r = module.userRequest;
  return typeof r === 'string' && r.indexOf('/node_modules/') >= 0;
}

var config = {
  // What file to start at
  entry: [path.join(SRC_PATH, 'main.coffee')],

  // Where to output
  output: {
    path: BUILD_PATH,
    publicPath: '/static/',
    filename: '[name].js',
  },

  module: {
    // What to load
    loaders: [
      { // Coffeescript (DO NOT MOVE)
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
  },

  plugins: [
    new webpack.optimize.CommonsChunkPlugin({
      name: 'vendor',
      minChunks: isVendor
    }),
  ],
};

// Development
if (process.env.NODE_ENV === 'production') {
  config.plugins.unshift(
    // Production environment variable
    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify('production')
      }
    }),

    // Deduplicate
    new webpack.optimize.DedupePlugin()
  );
  config.plugins.push(
    // Minify
    new webpack.optimize.UglifyJsPlugin({
      compress: {warnings: false}
    })
  );
} else {
  // Source maps
  config.devtool = 'eval';
}

module.exports = config;
