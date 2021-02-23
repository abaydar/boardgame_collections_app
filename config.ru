require './config/environment'

use Rack::MethodOverride


use UsersController
use BoardgamesController
run ApplicationController
