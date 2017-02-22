require 'json'
require 'active_record'
require 'active_support/core_ext/string' # for using 'camelize' (stackoverflow.com/questions/18732338/)

module Greeter end # for use in lib/models

require 'models/greeter'

require 'greeter_home'
require 'config'

Greeter::Config.instance
