require File.dirname(__FILE__) + '/element'

# Basic Checkbox object.
# Subclass of Element.
class Checkbox_GWT < Element
    # Verifies if value of checkbox is checked or uncheck, then procedes to check/
    # uncheck object, like user clicks on checkbox.
    def click
      @selenium.click(@locator)
      begin
        @selenium.wait_for_condition('selenium.browserbot.getCurrentWindow().jQuery.active == 0', 10000)
      rescue => e
        #continue
        sleep(4)
      end
      sleep(3)
    end
    
    # returns current value of object.
    def value
      return @selenium.is_checked(@locator)
    end
    
end