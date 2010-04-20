require "rubygems"
require File.dirname(__FILE__) + '/../vendor/selenium-client-1.2.17/lib/selenium'
gem "rspec"
require File.dirname(__FILE__) + '/../vendor/selenium-client-1.2.17/lib/selenium/rspec/spec_helper'
require 'find'
require 'fileutils'
require File.dirname(__FILE__) + '/../config/site_config'

Dir.glob(File.join(File.dirname(__FILE__), '/../common/**/*.rb')).each {|f| require f }
Dir.glob(File.join(File.dirname(__FILE__), '/../scripts/**/*.rb')).each {|f| require f }
Dir.glob(File.join(File.dirname(__FILE__), '/../sites/**/**/*.rb')).each {|f| require f }
Dir.glob(File.join(File.dirname(__FILE__), '/../sites/**/*.rb')).each {|f| require f }

include Common
include FileUtils

def start_selenium_session(site)
    @selenium_driver = Selenium::Client::Driver.new \
          :host => SELENIUM_HOST, 
          :port => SELENIUM_PORT, 
          :browser => BROWSER,
          :timeout_in_seconds => TIMEOUT_SEC,
          :url => site,
          :highlight_located_element => true
    @selenium_driver.start_new_browser_session
    @selenium_driver.set_speed BROWSER_DELAY
    @@TEST_FAILURE = false
end

def stop_selenium_session
    @selenium_driver.close_current_browser_session
end
