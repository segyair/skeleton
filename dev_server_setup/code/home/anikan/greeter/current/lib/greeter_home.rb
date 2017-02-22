require 'erb'

class GreeterHome
  
  # http://localhost:9092/index.html

  def self.call(env)
    new(env).response.finish
    #out = ""
    #env.keys.each {|key| out+="#{key}=#{env[key]}\n"}
    #["200", {"Content-Type" => "text/plain"}, [out]]
  end
  
  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response
    home = "/index.html"
    case @request.path
    when home then Rack::Response.new(render("index.html.erb"))
    when "/change" 
      Rack::Response.new do |response|
        response.set_cookie("greet", @request.params['name'])
        Greeter::Models::Greeter.create(name: @request.params['name'])
        response.redirect(home)
      end
    else Rack::Response.new("Not Found", 404)
    end
    #[200 ,{"Content-Type" => "text/plain"}, ["Hello Rack!"]]
  end
  
  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def greet_name
    @request.cookies["greet"] || "World"
  end

  def host_ip
    `curl -s http://169.254.169.254/latest/meta-data/public-ipv4`
  end
end
