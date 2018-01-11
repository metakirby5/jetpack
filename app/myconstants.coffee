# Constants for the app.

import config from '../config'

export API = config.api
export IS_DEV = process.env.NODE_ENV is 'development'
