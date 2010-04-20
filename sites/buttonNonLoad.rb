require File.dirname(__FILE__) + '/element'

# Button object used when no page load occurs after clicking.
# Subclass of Element.
class ButtonNonLoad < Element
    # Clicks on object
    def click
	@selenium.click(@locator)
	sleep(1)
    end
end