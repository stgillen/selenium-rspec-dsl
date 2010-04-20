require File.dirname(__FILE__) + '/element'

# Basic Dropdown object.
# Subclass of Element.
class Dropdown < Element
    # Selects provided text value in object; based on option label
    def select(text)
	@selenium.select(@locator,"label=#{text}")
    end
    
    # Selects provided text value in object; based on option index
    def selectIndex(text)
        @selenium.select(@locator,"index=#{text}")
    end
    
    # Selects provided text value in object; based on option value
    def selectValue(text)
        @selenium.select(@locator,"value=#{text}")
    end
    
    def selectedText
	return @selenium.get_selected_label(@locator)	
    end
end




