require File.dirname(__FILE__) + '/element'

# Link object used when no page load occurs after clicking.
# Subclass of Element.
class LinkNonLoad < Element
    # Clicks on object
    def click
	@selenium.click(@locator)
	#@selenium.wait_for_condition("selenium.browserbot.getCurrentWindow()",TIMEOUT);
    end
end