require 'mysql2'
require 'json'

DEV__CONF_FILE_PATH = "/home/anikan/dev/tutorial/greeter/code/home/anikan/greeter/current/config.json"
PROD_CONF_FILE_PATH = "/home/anikan/greeter/current/config.json"
path = nil

if File.exists?(DEV__CONF_FILE_PATH)
  path = DEV__CONF_FILE_PATH
elsif File.exists?(PROD_CONF_FILE_PATH)
  path = PROD_CONF_FILE_PATH
else
  raise "config.json is missing please create one!\n  dev: #{DEV__CONF_FILE_PATH}\n  prod: #{PROD_CONF_FILE_PATH})" 
end

@config = JSON.parse(File.read(path))
host     = @config["database"]["host"]
username = @config["database"]["username"]
password = @config["database"]["password"]
port     = @config["database"]["port"]
database = @config["database"]["database"]

client = Mysql2::Client.new(host: host, username: username, password: password, port: port)
client.query("CREATE DATABASE IF NOT EXISTS #{database}")
client.close
