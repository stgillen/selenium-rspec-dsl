require File.dirname(__FILE__) + '/element'

class Button_Ajax < Element
    # Clicks on object
    def click
	@selenium.click(@locator)
	begin
	  @selenium.wait_for_ajax
	rescue => e
	  #continue
	end
	sleep(4)
    end
end