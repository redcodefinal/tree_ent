require 'sinatra'
require 'erb'
require 'yaml'


class TreeEnt::Server < Sinatra::Base
  Thread.new do
    while true
      TreeEnt.update
      sleep 1
    end
  end

  set :run, true
  set :port, 4200
  mime_type :yaml, "text/yaml"

  get "/" do
    "TREEENT"
  end

  get "/api" do
    "GOT API SUCCESSFULLY!"
  end

  get "/api/switches" do
    content_type :yaml
    YAML.dump TreeEnt.switches
  end


  get "/api/switches/:name" do |name|
    content_type :yaml
    if TreeEnt.switches[name.to_sym]
      YAML.dump TreeEnt.switches[name.to_sym]
    else
      YAML.dump "ERROR!"
    end
  end

  get "/api/switches/:name/turn_on" do |name|
    content_type :yaml
    if TreeEnt.switches[name.to_sym]
      TreeEnt.switches[name.to_sym].turn_on
      YAML.dump "SUCCESS"
    else
      YAML.dump "ERROR"
    end
  end

  get "/api/switches/:name/turn_off" do |name|
    content_type :yaml
    if TreeEnt.switches[name.to_sym]
      TreeEnt.switches[name.to_sym].turn_off
      YAML.dump "SUCCESS"
    else
      YAML.dump "ERROR"
    end
  end

  get "/api/switches/:name/toggle" do |name|
    content_type :yaml
    if TreeEnt.switches[name.to_sym]
      TreeEnt.switches[name.to_sym].toggle
      YAML.dump "SUCCESS"
    else
      YAML.dump "ERROR"
    end
  end

  get "/api/modules" do
    content_type :yaml
    YAML.dump TreeEnt.modules
  end

  get "/api/modules/:name" do |name|
    content_type :yaml
    if TreeEnt.modules[name.to_sym]
      YAML.dump TreeEnt.modules[name.to_sym]
    else
      YAML.dump "ERROR!"
    end
  end
end