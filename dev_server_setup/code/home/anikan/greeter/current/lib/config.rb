require 'singleton'

module Greeter
  class Config

    include Singleton

    CONF_FILE_PATH = File.expand_path("../../config.json", __FILE__)

    def initialize
      raise "config.json is missing please create one! (here: #{CONF_FILE_PATH})" unless File.exists?(CONF_FILE_PATH)
      @config = JSON.load(File.read(CONF_FILE_PATH))
      @database_params = @config["database"]
      ActiveRecord::Base.establish_connection(@database_params)
    end
  end
end