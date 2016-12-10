'use strict';

const path = require('path')
    , webpack = require('webpack')
    , merge = require('webpack-merge')
    , HtmlWebpackPlugin = require('html-webpack-plugin');

const
    // Environment
      ENV = process.env.npm_lifecycle_event

    // Module folders
    , VENDORS = ['node_modules', 'bower_components']
    , VENDOR_RE = new RegExp(VENDORS.join('|'))

    // Input and output folders
    , SRC_PATH = path.join(__dirname, 'src')
    , TEST_PATH = path.join(__dirname, 'test')
    , BUILD_PATH = path.join(__dirname, 'dist')

    // File names
    , INDEX = 'index'
    , MAIN = 'main'
    , TEST = 'spec'
    , VENDOR = 'vendor';

// Check if module is vendor, for chunking
const isVendor = (module) => {
  var r = module.userRequest;
  return typeof r === 'string' && r.match(VENDOR_RE);
}

var config = {
  // What file to start at
  entry: {
    [MAIN]: path.join(SRC_PATH, `${MAIN}.coffee`),
  },

  // Where to output
  output: {
    path: BUILD_PATH,
    filename: '[name].js',
  },

  // Where to load modules from
  resolve: {
    root: SRC_PATH,
    modulesDirectories: VENDORS,
    extensions: ['', '.coffee', '.l.styl', '.styl', '.js', '.css']
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

  // Module loading options
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

    // Files to load
    loaders: [
      { // Pug
        test: /\.pug$/,
        loaders: ['pug-html'],
      },
      { // Coffeescript
        test: /\.coffee$/,
        loaders: ['coffee'],
      },
      { // Stylus (locally scoped)
        test: /\.l.styl$/,
        loaders: ['style', 'css?modules', 'stylus'],
      },
      { // Stylus (globally scoped)
        test: /\.styl$/,
        exclude: /\.l.styl$/,
        loaders: ['style', 'css', 'stylus'],
      },
      { // Plain CSS
        test: /\.css$/,
        loaders: ['style', 'css'],
      },
      { // Media
        test: /\.(png|jpe?g|gif|svg|woff2?|eot|ttf)$/,
        loaders: ['url'],
      },
    ],
  },

  plugins: [
    // Generate HTML
    new HtmlWebpackPlugin({
      template: path.join(SRC_PATH, `${INDEX}.pug`),
    }),
    // Separate vendor bundle
    new webpack.optimize.CommonsChunkPlugin({
      name: VENDOR,
      minChunks: isVendor,
    }),
  ],
};

// Options based on environment
switch (ENV) {
  case 'start': // Development
    console.log('Running development server...');
    config = merge(config, {
      // Source maps
      devtool: 'cheap-module-eval-source-map',

      // -- Hot loading --

      module: {
        loaders: [
          {
            test: /\.coffee$/,
            loaders: ['react-hot-loader/webpack'],
          },
        ],
      },

      plugins: [
        // Devevelopment environment variable
        new webpack.DefinePlugin({
          'process.env': {
            'NODE_ENV': '"development"',
          },
        }),

        new webpack.HotModuleReplacementPlugin(),
      ],

      devServer: {
        // Public serving
        host: '0.0.0.0',

        // No iframe
        inline: true,

        // Show progress
        progress: true,

        // Hot reloading
        hot: true,

        // Allow routing
        historyApiFallback: true,

        // Display options
        stats: {
          // Do not show list of hundreds of files included in a bundle
          chunkModules: false,
          colors: true,
        },
      },
    });
    break;

  case 'build': // Production
    console.log('Building production scripts...');
    config = merge(config, {
      plugins: [
        // Production environment variable
        new webpack.DefinePlugin({
          'process.env': {
            'NODE_ENV': '"production"',
          },
        }),

        // Deduplicate
        new webpack.optimize.DedupePlugin(),

        // Minify
        new webpack.optimize.UglifyJsPlugin({
          compress: {warnings: false},
        }),
      ],
    });
    break;

  case 'test': // Test
  case 'test:watch':
    console.log('Testing...');

    // Set up testing src and path
    config.entry = {
      [TEST]: path.join(TEST_PATH, `${TEST}.coffee`),
    };
    config.output.path = TEST_PATH;

    // Disable output bundling
    config.plugins = [];

    config = merge(config, {
      // Build for node
      target: 'node',
      externals: [require('webpack-node-externals')()],

      // Source maps
      devtool: 'inline-source-map',

      plugins: [
        // Test environment variable
        new webpack.DefinePlugin({
          'process.env': {
            'NODE_ENV': '"test"',
          },
        }),
      ],
    });
    break;
}

module.exports = config;
