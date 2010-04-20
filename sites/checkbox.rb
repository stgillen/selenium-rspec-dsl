require File.dirname(__FILE__) + '/element'

# Basic Checkbox object.
# Subclass of Element.
class Checkbox < Element
    # Verifies if value of checkbox is checked or uncheck, then procedes to check/
    # uncheck object, like user clicks on checkbox.
    def click
	boxChecked = self.value
	if boxChecked
	    @selenium.uncheck(@locator)
	else
	    @selenium.check(@locator)
	end
    end
    
    # returns current value of object.
    def value
	return @selenium.is_checked(@locator)
    end
    
end
