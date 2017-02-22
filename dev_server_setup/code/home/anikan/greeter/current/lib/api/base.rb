require 'grape'
require 'api/v1'
require 'api/v2'


module API
  class Base < Grape::API
    # this 'api' is part of the url request:
    # http://localhost:9092/api/v1/monitor.json
    mount API::V1 => 'api'
    mount API::V2 => 'api'
  end
end