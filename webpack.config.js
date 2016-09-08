'use strict';

var path = require('path')
  , webpack = require('webpack');

const SRC_PATH = path.join(__dirname, 'src')
    , BUILD_PATH = path.join(__dirname, 'static');

// Check if module is vendor, for chunking
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

  // Don't tolerate errors
  bail: true,

  // Coffeelint options
  coffeelint: {
    configFile: './coffeelint.json'
  },

  // Stylint options
  stylint: {
    config: './.stylintrc'
  },

  module: {
    // Linters, etc
    preLoaders: [
      {
        test: /\.coffee$/,
        loader: 'coffee-lint',
        exclude: /node_modules/
      },
      {
        test: /\.styl/,
        loader: 'stylint',
        exclude: /node_modules/
      },
    ],

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
    ],
  },

  plugins: [
    new webpack.optimize.CommonsChunkPlugin({
      name: 'vendor',
      minChunks: isVendor
    }),
  ],
};

// Production
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

// Development
} else {
  // Source maps
  config.devtool = 'eval';

  // -- Hot loading --

  config.entry.unshift('webpack/hot/only-dev-server');

  // loaders[0] is coffee
  config.module.loaders[0].loaders.unshift('react-hot-loader/webpack');
  config.plugins.unshift(new webpack.HotModuleReplacementPlugin());

  config.devServer = {
    // Adjust entry point
    inline: true,

    // Hot reloading
    hot: true,

    // Allow routing
    historyApiFallback: true,

    stats: {
      // Do not show list of hundreds of files included in a bundle
      chunkModules: false,
      colors: true
    },
  }
}

module.exports = config;
