require File.dirname(__FILE__) + '/element'

class DropdownLoad < Element
    # Selects provided text value in object 
    def select(text)
	@selenium.select(@locator,"label=#{text}")
	@selenium.wait_for_page_to_load
    end
    
    # Selects provided text value in object; based on option index
    def selectIndex(text)
        @selenium.select(@locator,"index=#{text}")
        @selenium.wait_for_page_to_load
    end
    
    # Selects provided text value in object; based on option value
    def selectValue(text)
        @selenium.select(@locator,"value=#{text}")
        @selenium.wait_for_page_to_load
    end
    
    def selectedText
	return @selenium.get_selected_label(@locator)	
    end	
end