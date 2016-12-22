path = require 'path'
webpack = require 'webpack'
merge = require 'webpack-merge'
HtmlWebpackPlugin = require 'html-webpack-plugin'

projectConfig = require './config'

# Constants
{
  # Environment
  env: ENV
  api: API
  ports:
    app: PORT

  # Input and output folders
  app: SRC_PATH
  test: TEST_PATH
  dist: BUILD_PATH
} = projectConfig

# Module folders
VENDORS = ['node_modules', 'bower_components']
VENDOR_RE = new RegExp VENDORS.join '|'

# File names
INDEX = 'index'
MAIN = 'main'
TEST = 'app'
VENDOR = 'vendor'

# Check if module is vendor, for chunking
isVendor = (module) ->
  r = module.userRequest
  typeof r is 'string' and r.match VENDOR_RE

# The main config
config =
  # What file to start at
  entry: [path.join SRC_PATH, "#{MAIN}.coffee"]

  # Where to output
  output:
    path: BUILD_PATH
    publicPath: '/'
    filename: '[name].js'

  # Where to load modules from
  resolve:
    root: SRC_PATH
    modulesDirectories: VENDORS
    extensions: ['', '.coffee', '.l.styl', '.styl', '.js', '.css']

  # Stylus options
  stylus:
    use: [(require 'nib')()]
    import: ['~nib/lib/nib/index.styl']
    preferPathResolver: 'webpack'

  # Coffeelint options
  coffeelint:
    configFile: 'coffeelint.json'

  # Stylint options
  stylint:
    config: 'stylint.json'

  # Module loading options
  module:
    # Linters, etc.
    preLoaders: [
      # Coffeelint
      test: /\.coffee$/
      loaders: ['coffee-lint']
      exclude: VENDOR_RE
    ,
      # Stylint
      test: /\.styl/
      loaders: ['stylint']
      exclude: VENDOR_RE
    ]

    # Files to load
    loaders: [
      # Pug
      test: /\.pug$/
      loaders: ['pug-html']
    ,
      # Coffeescript
      test: /\.coffee$/
      loaders: ['coffee']
    ,
      # Stylus (locally scoped)
      test: /\.l\.styl$/
      loaders: ['style', 'css?modules', 'stylus']
    ,
      # Stylus (globally scoped)
      test: /\.styl$/
      exclude: /\.l\.styl$/
      loaders: ['style', 'css', 'stylus']
    ,
      # Plain CSS
      test: /\.css$/
      loaders: ['style', 'css']
    ,
      # Media
      test: /\.(png|jpe?g|gif|svg|woff2?|eot|ttf)$/
      loaders: ['url']
    ]

  plugins: [
    # Generate HTML
    new HtmlWebpackPlugin
      template: path.join SRC_PATH, "#{INDEX}.pug"

    # Separate vendor bundle
    new webpack.optimize.CommonsChunkPlugin
      name: VENDOR
      minChunks: isVendor
  ]

# Dev server config
devServerOpts =
  # Serve publicly
  host: '0.0.0.0'

  # Use defined port
  port: PORT

  # No iframe
  inline: true

  # Show progress
  progress: true

  # Hot reloading
  hot: true

  # Allow routing
  historyApiFallback: true

  # Display options
  stats:
    # Don't show a bunch of chunk stats
    chunkModules: false

    # Pretty colors
    colors: true

# Options based on environment
switch ENV
  when 'dev'  # Development
    console.log 'Running development server...'
    config = merge config,
      # Source maps
      devtool: 'cheap-module-eval-source-map'

      # React hot loading
      module:
        loaders: [
          test: /\.coffee$/
          loaders: ['react-hot-loader/webpack']
        ]

      plugins: [
        # Development environment variable
        new webpack.DefinePlugin
          'process.env':
            NODE_ENV: '"development"'

        # General hot loading
        new webpack.HotModuleReplacementPlugin()
      ]

      devServer: devServerOpts

  when 'build'  # Production
    console.log 'Building production scripts...'
    config = merge config,
      plugins: [
        # Production environment variable
        new webpack.DefinePlugin
          'process.env':
            NODE_ENV: '"production"'

        # Optimize chunking
        new webpack.optimize.OccurrenceOrderPlugin()

        # Deduplicate
        new webpack.optimize.DedupePlugin()

        # Minify
        new webpack.optimize.UglifyJsPlugin
          compress:
            warnings: false
      ]

  when 'test', 'test:watch', 'test:browser'  # Test
    process.stdout.write 'Testing '

    # Set up testing output
    config.output.path = TEST_PATH

    # Source maps
    config.devtool = 'inline-source-map'

    # View tests on browser
    if ENV.match 'browser'
      console.log 'with dev server...'

      # Set up testing input
      config.entry = [path.join "mocha!#{TEST_PATH}", "#{TEST}.coffee"]

      config.plugins = [
        # Generate test HTML
        new HtmlWebpackPlugin
          template: path.join TEST_PATH, "#{INDEX}.pug"

        # General hot loading
        new webpack.HotModuleReplacementPlugin()
      ]

      config.devServer = devServerOpts

    # View tests on CLI
    else
      console.log 'on the command line...'

      # Set up testing input
      config.entry = [
        'source-map-support/register'
        path.join TEST_PATH, "#{TEST}.coffee"
      ]

      # Build for node
      config.target = 'node'

      # Disable output bundling
      config.plugins = []

    # Test environment variable
    config.plugins.push new webpack.DefinePlugin
      'process.env':
        NODE_ENV: '"test"'

# Export the configuration
module.exports = config
