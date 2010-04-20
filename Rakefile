require 'rake'
require 'spec/rake/spectask'
require 'rake/gempackagetask'
require 'rake/packagetask'
require 'rake/rdoctask'
require File.dirname(__FILE__) + '/vendor/selenium-client-1.2.17/lib/selenium/rake/tasks'
require 'rubygems'
require 'spec'

require "net/http"
require "yaml"

require File.dirname(__FILE__) + '/vendor/selenium-grid-1.0.4/lib/ruby/tcp_socket_extensions'
require File.dirname(__FILE__) + '/vendor/selenium-grid-1.0.4/lib/ruby/file_extensions'
require File.dirname(__FILE__) + '/vendor/selenium-grid-1.0.4/lib/ruby/java/classpath'
require File.dirname(__FILE__) + '/vendor/selenium-grid-1.0.4/lib/ruby/java/vm'
require File.dirname(__FILE__) + '/vendor/selenium-grid-1.0.4/lib/ruby/s_grid/hub'
require File.dirname(__FILE__) + '/vendor/selenium-grid-1.0.4/lib/ruby/s_grid/remote_control'

dir = File.dirname(__FILE__)
time = Time.new.strftime('%m%d%Y_%H%M')

hubIP = "localhost"
lab1 = "localhost"
defaultBrowser = "*firefox"

spec = Gem::Specification.new do |s|
    s.name       = "selenium-rspec-dsl"
    s.version    = "1.0.2"
    s.author     = "Scott Gillenwater"
    s.email      = "scott.gillenwater@gmail.com"
    s.summary    = "A DSL using Selenium and Rspec"
    s.description = "A DSL using Selenium and Rspec that simplifies the creation, maintainability, and readablilty of automation tests."
    s.files      = FileList["{common,config,doc,scripts,sites,spec,vendor}/**/*"].exclude("rdoc").to_a
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_tar = true
end

desc "Launch Hub/Grid"
task :'hub:start' do
  classpath = Java::Classpath.new(File.dirname(__FILE__) + '/vendor/selenium-grid-1.0.4')
  classpath = classpath << "." << "lib/selenium-grid-hub-standalone-*.jar"
  puts classpath.inspect
  Java::VM.new.run "com.thoughtworks.selenium.grid.hub.HubServer",
                    :classpath => classpath.definition,
                    :background => ("true" == ENV['BACKGROUND']),
                    :log_file => File.native_path(File.dirname(__FILE__) + "/vendor/selenium-grid-1.0.4/log/hub.log")
end

#desc "Stop Hub"
task :'hub:stop' do
  puts "Shutting down Selenium Grid hub..."
  http = Net::HTTP.new("localhost", hub_port)
  http.post('/lifecycle-manager', "action=shutdown")
end

desc "Launch Remote Control/Server (Linux)"
task :'rc:start' do
  launch_rc(:host => (ENV['HOST'] || "localhost"), :port => (ENV['PORT'] || 5555),
    :environment => (ENV['ENVIRONMENT'] || defaultBrowser),
    :hub_url => (ENV['HUB_URL'] || "http://localhost:#{hub_port}"),
    :selenium_args => (ENV['SELENIUM_ARGS'] || "-firefoxProfileTemplate #{dir}/vendor/firefoxProfiles/default"))
end

desc"Stop Remote Controls. Usage rake rc:stop PORTS 5000-5020"
task :'rc:stop_all' do
  ports = ENV['PORTS'] || "5000-5009"
  port_range = Range.new(*ports.split("-"))
  port_range.each do |port|
    begin
      puts "Stopping Remote Control on port #{port}"
      rc = SGrid::RemoteControl.new :host => ENV['HOST'] || "localhost",      
                                    :port => port
      rc.shutdown
    rescue Exception => e
      STDERR.puts "Could not properly shutdown remote control #{port} : #{e}"
    end
  end
end

task :'rc:start_windows' do
  launch_rc(:host => (ENV['HOST'] || "localhost"), :port => (ENV['PORT'] || 5555),
    :environment => (ENV['ENVIRONMENT'] || "Windows-Firefox3"),
    :hub_url => (ENV['HUB_URL'] || "http://localhost:#{hub_port}"),
    :selenium_args => (ENV['SELENIUM_ARGS'] || "-firefoxProfileTemplate #{dir}/vendor/firefoxProfiles/default"))
end

desc "Stop Remote Control"
task :'rc:stop' do
  http = Net::HTTP.new("localhost", ENV['PORT'] || 5555)
  puts http.post('/selenium-server/driver/', "cmd=shutDown")
end

desc "Generate documentation"
Rake::RDocTask.new("rdoc") do |rdoc|
  rdoc.title    = "Automation Commands"
  rdoc.main = "README"
  rdoc.rdoc_dir = "doc"
  rdoc.rdoc_files.include('sites/*.rb', 'spec/**/*.rb')
  rdoc.options << '--line-numbers' << '--inline-source' 
end 

# Sample Multi-Process Task
desc("Starts Test specs")
task :test_specs => :report_dir do
  require File.expand_path(File.dirname(__FILE__) + '/config/multi_process_behaviour_runner')
  processes = (ENV['PROCESSES'] || 1)
  runner = MultiProcessSpecRunner.new(processes.to_i)
  runner.run(Dir['spec/test/*_spec.rb'], "Example Tests")
end

task :default  => :spec

task :report_dir do
  mkdir_p File.expand_path(File.dirname(__FILE__) + "/doc")
  rm_f Dir[File.dirname(__FILE__) + "/doc/*.html"]
end

def launch_rc(options)
    # Selenium Server must be first in classpath
    classpath = Java::Classpath.new(File.dirname(__FILE__) + '/vendor/selenium-grid-1.0.4')
    classpath =  classpath << "." << "vendor/selenium-server-*.jar" << "lib/selenium-grid-remote-control-standalone-*.jar"
  
    Java::VM.new.run "com.thoughtworks.selenium.grid.remotecontrol.SelfRegisteringRemoteControlLauncher",
                     :classpath => classpath.definition,
                     :args => rc_args(options),
                     :background => ("true" == ENV['BACKGROUND']),
                     :log_file => File.join(File.dirname(__FILE__) + '/vendor/selenium-grid-1.0.4', "log", "rc-#{options[:port]}.log")
                     
end

def remote_control(options={})
  SGrid::RemoteControl.new(
      :host => ENV['HOST'] || "localhost",
      :port => (options[:port] || ENV['PORT'] || 5555),
      :hub_url => (ENV['HUB_URL'] || "http://localhost:#{hub_port}"),
      :shutdown_command => ENV['RC_SHUTDOWN_COMMAND'])
end

def rc_args(options)
  args = []
  args << "-host" << (options[:host]) #|| ENV['HOST'] || "localhost")
  args << "-port" << options[:port]
  args << "-hubUrl" << (options[:hub_url]) #|| ENV['HUB_URL'] || "http://localhost:#{hub_port}")
  args << "-env '#{options[:environment]}'" # || ENV['ENVIRONMENT'] || "*firefox"}'" 
  args << (options[:selenium_args])# || ENV['SELENIUM_ARGS'] || "")
  args
end

def hub_port
  (ENV["HUB_PORT"] || config["hub"]["port"]).to_i
end

def config
  @config ||= YAML.load(File.read(File.dirname(__FILE__) + "/vendor/selenium-grid-1.0.4/grid_configuration.yml"))
end

