require File.dirname(__FILE__) + '/element'

# Basic Button object.
# Subclass of Element.
class Button < Element
    # Type text into object if applicable
    def type(text)
        @selenium.type(@locator,text)
    end
    
    # Clicks on object and waits for page to load or refresh
    def click
	begin
	    @selenium.click(@locator)
	rescue => e
	    sleep(3)
	    @selenium.click(@locator)
	end

	begin
	    @selenium.wait_for_page_to_load
	rescue => e
	    sleep(2)
	    @selenium.wait_for_condition("selenium.browserbot.getCurrentWindow()", TIMEOUT)
	end
	
    end
end



