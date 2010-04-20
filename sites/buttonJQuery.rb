require File.dirname(__FILE__) + '/element'

class Button_JQuery < Element
  # Clicks on object
  def click
    @selenium.click(@locator)
    begin
      @selenium.wait_for_condition('selenium.browserbot.getCurrentWindow().jQuery.active == 0', 10000)
    rescue => e
      #continue
      sleep(4)
    end
    sleep(5)
  end
  
  def doubleClick
    @selenium.double_click(@locator)
    begin
      @selenium.wait_for_condition('selenium.browserbot.getCurrentWindow().jQuery.active == 0', 10000)
    rescue => e
      #continue
      sleep(4)
    end
    sleep(5)
  end
end