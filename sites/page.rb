require File.dirname(__FILE__) + '/element'

# Basic Page object.
# Subclass of Element.
class Page < Element
    # creates selenium and url variables for object
    def initialize(selenium, url)
	@selenium = selenium
	@url = url
    end
    
    # goes to the url specified
    def go()
	@selenium.open @url
    end
end