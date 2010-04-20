Dir.glob(File.join(File.dirname(__FILE__), '/../*.rb')).each {|f| require f }

class Google_Result_Screen
    
  def initialize(selenium)
    @selenium = selenium
  end
  
  def html_link(text)
    locator = "link=#{text}"
    obj = Link.new(@selenium, locator)
    return obj
  end
  
end