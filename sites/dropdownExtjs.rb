require File.dirname(__FILE__) + '/element'

class Dropdown_Extjs < Element
    def click
	if /parentNode.id/.match(@locator) != nil
	    @locator = @locator.gsub('parentNode.id','childNodes[1].id')
	    @object_id = @selenium.get_eval(@locator)
	    @selenium.click(@object_id)
	else    
	    @selenium.click(@locator)
	end
    end
    
    def select(text)
	self.click
	
	for wait in 1..60 do
	    begin
		@selenium.click("//div[contains(@class, 'x-combo-list')]/descendant::div[contains(@class, 'x-combo-list-item')][text()='"+text+"']") 
		break
	    rescue => e
		sleep(0.5)
	    end
	end
    end
    
    def type(text)
	self.click
	@selenium.type(@locator, text)
	@selenium.key_press(@locator, "\\9")	
    end
end
