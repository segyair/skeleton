$: << File.join(File.dirname(__FILE__), 'lib')

require "greeter"
require "api/base"

use Rack::Reloader, 0

run Rack::Cascade.new([Rack::File.new("public"), GreeterHome, API::Base])

