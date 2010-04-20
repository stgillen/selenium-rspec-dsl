require File.dirname(__FILE__) + '/element'

# Basic Textbox object.
# Subclass of Element.
class Textbox < Element
    #returns the current value of the object
    def value
        @value = @selenium.get_value(@locator)
        return @value
    end
    
    # Types specified text into object
    def type(text)
        @selenium.type(@locator,text)
    end
end