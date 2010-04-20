require File.dirname(__FILE__) + '/element'

# Basic listbox object.
# Subclass of Element.
class Listbox < Element
  def select(text)
    begin 
      @selenium.remove_all_selections(@locator)
      @selenium.add_selection(@locator,"label=#{text}")
    rescue => e
      sleep(3)
      @selenium.remove_all_selections(@locator)
      @selenium.add_selection(@locator,"label=#{text}")
    end
  end
end