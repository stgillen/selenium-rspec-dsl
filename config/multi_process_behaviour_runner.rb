require File.expand_path(File.dirname(__FILE__) + '/array_extension')
Array.send :include, ArrayExtension

class MultiProcessSpecRunner

  def initialize(max_concurrent_processes = 10)
    @max_concurrent_processes = max_concurrent_processes
  end
  
  def run(spec_files, section='')
    time = Time.new.strftime('%m%d%Y_%H%M')
    concurrent_processes = [ @max_concurrent_processes, spec_files.size ].min
    spec_files_by_process = spec_files / concurrent_processes
    concurrent_processes.times do |i|
      cmd  = "spec #{options(i,section)} #{spec_files_by_process[i].join(' ')}"
      puts "Launching #{cmd}"
      exec(cmd) if fork == nil
    end
    success = true
    concurrent_processes.times do |i|
      pid, status = Process.wait2
      success &&= status.exitstatus.zero?
    end

    script = File.expand_path(File.dirname(__FILE__) + "/aggregate_reports.rb")
    reports = Dir[screenshot_dir + "/*_Test_Report-*.html"].collect {|report| %{"#{report}"} }.join(' ')
    puts "reports: #{reports}"
    command = %{ruby "#{script}" #{reports} > "#{screenshot_dir}/Aggregated-Selenium-Report.html"}
    sh command
    
    #raise "Build failed" unless success
  end

  protected
 
  def options(process_number, section='')
    dir = File.dirname(__FILE__)
    
    [ "--require '#{dir}/../vendor/selenium-client-1.2.17/lib/selenium/rspec/reporting/selenium_test_report_formatter'",
      "--format='Selenium::RSpec::SeleniumTestReportFormatter:#{dir}/../doc/#{section}_Test_Report-#{process_number}.html'",
      "--color",
      "--format=progress"
    ].join(" ")
  end
  
  def screenshot_dir
    ENV['CC_BUILD_ARTIFACTS'] || File.expand_path(File.dirname(__FILE__) + "/../doc")
  end
    
end
