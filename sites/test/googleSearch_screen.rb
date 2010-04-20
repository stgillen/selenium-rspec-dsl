Dir.glob(File.join(File.dirname(__FILE__), '/../*.rb')).each {|f| require f }

class Google_Search_Screen
    
  def initialize(selenium)
    @selenium = selenium
  end
  
  def page
    locator = ""
    obj = Page.new(@selenium, locator)
    return obj
  end
  
  def search_textbox
    locator = "name=q"
    obj = Textbox.new(@selenium, locator)
    return obj
  end
  
  def googleSearch_button
    locator = "css=input[value='Google Search']"
    obj = Button.new(@selenium, locator)
    return obj
  end
  
end