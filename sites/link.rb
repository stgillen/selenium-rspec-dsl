require File.dirname(__FILE__) + '/element'

# Basic Link object.
# Subclass of Element.
class Link < Element
    # Clicks on object and waits for page to load or refresh
    def click(url=nil)
	if url == nil
	    begin
		@selenium.click(@locator)
	    rescue => e
		sleep(3)
		@selenium.click(@locator)
	    end
	    #sleep(2)
	    #@selenium.wait_for_condition("selenium.browserbot.getCurrentWindow()", TIMEOUT)	    
	    begin
		@selenium.wait_for_page_to_load
	    rescue => e
		sleep(2)
		@selenium.wait_for_condition("selenium.browserbot.getCurrentWindow()", TIMEOUT)	
	    end
	    
	else	    
	    @selenium.open_window(url,"newWindow")
	    @selenium.select_window("newWindow")
	end
    end
end



