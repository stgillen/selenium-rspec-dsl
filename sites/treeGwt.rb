require File.dirname(__FILE__) + '/element'

# Basic tree object.
# Subclass of Element.
class Tree_GWT < Element
  def click
    @selenium.mouse_over(@locator)
    @selenium.mouse_down(@locator)    
    begin
      @selenium.wait_for_condition('selenium.browserbot.getCurrentWindow().jQuery.active == 0', 10000)
    rescue => e
      #continue
      sleep(4)
    end
    sleep(3)
  end
  
  def doubleClick
    @selenium.mouse_over(@locator)
    @selenium.mouse_down(@locator)
    @selenium.mouse_up(@locator)
    @selenium.mouse_down(@locator)
    @selenium.mouse_up(@locator)
    begin
      @selenium.wait_for_condition('selenium.browserbot.getCurrentWindow().jQuery.active == 0', 10000)
    rescue => e
      #continue
      sleep(4)
    end
    sleep(3)
  end
end
