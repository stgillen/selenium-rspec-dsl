require File.dirname(__FILE__) + '/element'

class Dropdown_JQuery < Element
    
    def select(text)
	@selenium.select(@locator,"label=#{text}")
	begin
	  @selenium.wait_for_condition('selenium.browserbot.getCurrentWindow().jQuery.active == 0', 10000)
	rescue => e
	  #continue
	end
	sleep(4)
    end
    
        # Selects provided text value in object; based on option index
    def selectIndex(text)
        @selenium.select(@locator,"index=#{text}")
	begin
	  @selenium.wait_for_condition('selenium.browserbot.getCurrentWindow().jQuery.active == 0', 10000)
	rescue => e
	  #continue
	end
	sleep(4)
    end
    
    # Selects provided text value in object; based on option value
    def selectValue(text)
        @selenium.select(@locator,"value=#{text}")
	begin
	  @selenium.wait_for_condition('selenium.browserbot.getCurrentWindow().jQuery.active == 0', 10000)
	rescue => e
	  #continue
	end
	sleep(4)
    end
    
    def selectedText
	return @selenium.get_selected_label(@locator)	
    end
end