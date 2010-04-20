require File.dirname(__FILE__) + '/../../config/selenium-setup'

##########################################
# Description: Test Spec; automation test to validate selenium is working
# Prerequisite: N/A
# Jira Issue: none
# Author: Scott Gillenwater
##########################################

describe "Test (test/test_spec.rb)" do
  before :all do
    start_selenium_session "http://www.google.com"	
    @googleSearchScreen = Google_Search_Screen.new @selenium_driver
    @googleResultScreen = Google_Result_Screen.new @selenium_driver
  end
    
  after :all do
    stop_selenium_session
  end
    
  it "Go to Google search page" do
    @googleSearchScreen.page.go
  end
    
  it "Enter 'Google' into search textbox" do
    @googleSearchScreen.search_textbox.type "Google"
  end
    
  it "Click Google Search button" do
    @googleSearchScreen.googleSearch_button.click
  end
    
  it "should display link with text 'Google'" do
    @googleResultScreen.html_link("Google").exist.should be_true
  end
end
