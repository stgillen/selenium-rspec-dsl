require File.dirname(__FILE__) + '/element'

# Basic Checkbox object.
# Subclass of Element.
class Checkbox_Extjs < Element
    def click
	@selenium.mouse_down(@locator)
        @selenium.click(@locator)
    end
end
