require File.dirname(__FILE__) + '/element'

# Basic Label object.
# Subclass of Element.
class Label < Element
    # returns text content of object.
    def text
	sleep(2)
	if @object_id != nil
	    @text = @selenium.get_text(@object_id)
	else
	    #@text = @selenium.get_text(@locator)
	    for wait in 1..40 do
		begin
		    @text = @selenium.get_text(@locator)
		    if @text == '' 
			sleep(0.5)
		    else
			break
		    end
		rescue => e
		    sleep(0.5)
		end
	    end
	end
	return @text
    end
    
    def dragDrop(object_dragged_to)
	@selenium.drag_and_drop_to_object(@locator, object_dragged_to)
    end
end