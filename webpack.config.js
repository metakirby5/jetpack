'use strict';

var path = require('path')
  , webpack = require('webpack');

const SRC_PATH = path.join(__dirname, 'src')
    , BUILD_PATH = path.join(__dirname, 'static')
    , VENDORS = ['node_modules', 'bower_components'];

const VENDOR_RE = new RegExp(VENDORS.join('|'));

// Check if module is vendor, for chunking
const isVendor = (module) => {
  var r = module.userRequest;
  return typeof r === 'string' && r.match(VENDOR_RE);
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

  // Where to load modules from
  resolve: {
    modulesDirectories: VENDORS,
    extensions: ['', '.coffee', '.styl', '.js', '.css']
  },

  // Where to load loaders from
  resolveLoader: {
    modulesDirectories: VENDORS,
  },

  // Coffeelint options
  coffeelint: {
    configFile: 'coffeelint.json',
  },

  // Stylus options
  stylus: {
    use: [require('nib')()],
    import: ['~nib/lib/nib/index.styl'],
    preferPathResolver: 'webpack',
  },

  // Stylint options
  stylint: {
    config: '.stylintrc',
  },

  module: {
    // Linters, etc
    preLoaders: [
      { // Coffeelint
        test: /\.coffee$/,
        loader: 'coffee-lint',
        exclude: VENDOR_RE,
      },
      { // Stylint
        test: /\.styl/,
        loader: 'stylint',
        exclude: VENDOR_RE,
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
        loaders: ['style', 'css', 'stylus'],
      },
      { // Reference-counted stylus
        test: /\.u\.styl/,
        loaders: ['style/useable', 'css', 'stylus'],
      },
      { // Plain CSS
        test: /\.css$/,
        loaders: ['style', 'css'],
      },
      { // Media
        test: /\.(png|jpe?g|gif|svg|woff|woff2|eot|ttf)$/,
        loaders: ['url'],
      },
    ],
  },

  plugins: [
    new webpack.optimize.CommonsChunkPlugin({
      name: 'vendor',
      minChunks: isVendor,
    }),
  ],
};

// Production
if (process.env.NODE_ENV === 'production') {
  config.plugins.unshift(
    // Production environment variable
    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify('production'),
      },
    }),

    // Deduplicate
    new webpack.optimize.DedupePlugin()
  );
  config.plugins.push(
    // Minify
    new webpack.optimize.UglifyJsPlugin({
      compress: {warnings: false},
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
      colors: true,
    },
  };
}

module.exports = config;
