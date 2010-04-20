#!/usr/bin/env ruby

def parse_header(html)
  html =~ /(.*<div class="results">)/mi
  $1
end

def parse_footer(html)
  html[/<\/div>\s*<\/body>.*/mi]
end

def parse_body(html)  
  html =~ /<div class="results">(.*)<\/div>\s*<\/body>/mi
  content = $1
end

body = ""
header = nil
footer = nil
count = 1
duration = 0
totalExamples = 0
totalFailures = 0
totalPending = 0
longestDuration = 0
totalSpecs = 0
numberOfSpecsFailures = 0

ARGV.each do |file|
  lines = IO.readlines(file)
  html = lines.join(' ')
  
  # loop corrects color coding in report
  numberOfSpecs = html.scan("class=\"example_group\"").size
  numberOfSpecsFailures += html.scan("Show Dynamic HTML Snapshot").size
  totalSpecs += (numberOfSpecs - 1)
  spec = 1
  while spec <= numberOfSpecs do
    numberOfGroups = html.scan("example_group_#{spec.to_s}").size
    group = 1
    while group <= numberOfGroups
      html = html.gsub("\"example_group_#{spec.to_s}\"", "\"example_group#{spec.to_s}#{group.to_s}#{count.to_s}\"")
      html = html.gsub("('example_group_#{spec.to_s}')", "('example_group#{spec.to_s}#{group.to_s}#{count.to_s}')")
      group += 1
    end
    spec += 1
  end
  
   
  # updates report with correct duration in header
  startSub = html.rindex("<strong>")
  endSub = html.rindex(" seconds</strong>")  
  durationString = html[startSub+8, endSub]
  
  if durationString.to_f > longestDuration
    longestDuration = durationString.to_f
  end
  
  duration += durationString.to_f  
  html = html.gsub(/Finished in <strong>.* seconds<\/strong>/, "Finished in <strong>#{longestDuration.to_s} seconds;</strong> Total Time in <strong>#{duration.to_s} seconds</strong>")
  
  # updates report with correct example count in header
  startSub = html.rindex(/innerHTML = ".* examples?/)
  if startSub == nil
    startSub = 0
  end
  endSub = html.rindex(/ examples?, .* failures?/)
  if endSub == nil
    endSub = 0
  end
  examplesString = html[startSub+13, endSub]
  totalExamples += examplesString.to_i
  html = html.gsub(/innerHTML = ".* examples?/, "innerHTML = \"#{totalSpecs.to_s} specs, #{numberOfSpecsFailures.to_s} specs failed, #{totalExamples.to_s} examples")
  
  ## updates report with correct failure count in header
  startSub = html.rindex(/ examples, .* failures?/)
  if startSub == nil
    startSub = 0
  end
  endSub = html.rindex(/ failures?/) 
  if endSub == nil
    endSub = 0
  end 
  failuresString = html[startSub+11, endSub]
  totalFailures += failuresString.to_i
  html = html.gsub(/ examples, .* failures?/, " examples, #{totalFailures.to_s} example failures")
  
  if /failures?, .* pending"/.match(html) 
    startSub = html.rindex(/failures?, .* pending"/)
    if startSub == nil
      startSub = 0
    end
    endSub = html.rindex(/ pending"/)
    if endSub == nil
      endSub = 0
    end  
    pendingString = html[startSub+10, endSub]
    totalPending += pendingString.to_i
    html = html.gsub(/failures?, .* pending/, "failures, #{totalPending.to_s} examples pending")
  else
    html = html.gsub(/failures?/, "failures, #{totalPending.to_s} examples pending")
  end
  
  if totalFailures > 0
    #red
    startSub = html.rindex(/pending\";<\/script>/)
    html.insert(startSub+18, "<script type=\"text/javascript\">makeRed('rspec-header');</script>")
  elsif totalPending > 0
    #yellow
    startSub = html.rindex(/pending\";<\/script>/)
    html.insert(startSub+18, "<script type=\"text/javascript\">makeYellow('rspec-header');</script>")
  else
    #green; do nothing
  end
  
  header ||= parse_header(html)
  footer ||= parse_footer(html)
  body << parse_body(html).to_s
  count += 1
end

STDOUT.puts header
STDOUT.puts body
STDOUT.puts footer
