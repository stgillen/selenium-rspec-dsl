require File.dirname(__FILE__) + '/element'

# Basic Radiobutton object.
# Subclass of Element.
class Radiobutton < Element
  # returns current value of object.
    def value
	return @selenium.is_checked(@locator)
    end
end