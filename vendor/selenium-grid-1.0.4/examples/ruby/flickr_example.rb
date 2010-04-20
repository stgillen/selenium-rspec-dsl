module FlickrExample
  
  def run_flickr_scenario(options)
    browser.open "/"
    page.location.should match(%r{http://images.google.com/})
    page.type "q", options[:search_string]
    page.click "btnG", :wait_for => :page
    page.click "link=Advanced Image Search", :wait_for => :page
    page.click "rimgtype4"
    page.click "sf"
    page.select "imgc", "full color"
    page.click "btnG", :wait_for => :page
    page.text?(options[:search_string].split(/ /).first).should be_true
  end
  
end
