require File.dirname(__FILE__) + '/element'

# Button object used when multiple window or popups occur after clicking.
# Subclass of Element.
class ButtonMultiWindow < Element
    # Clicks on object, waits for expectedWindows count and then selects new window.
    def click(expectedWindows=1)
	
	if expectedWindows == 1
	    @selenium.click(@locator)
	    @selenium.select_window "null"
	    sleep(3)
	    @selenium.wait_for_condition("selenium.browserbot.getCurrentWindow()", TIMEOUT)
	    
	else
	    begin
		id = @selenium.get_attribute("#{@locator}@id")
		url = @selenium.get_eval("window.document.getElementById('#{id}').href")
	    rescue => e
		url = "null"
	    end	
	    if url == "null"
		windows = @selenium.get_all_window_ids()		
		@selenium.click(@locator)
		
		for wait in 1..20 do
		    windows = @selenium.get_all_window_ids()		    
		    if expectedWindows != windows.length
			sleep(0.5)
		    else
			sleep(5)
			break
		    end
		end	
		if expectedWindows < windows.length
		    begin
			window_names = @selenium.get_all_window_names()
			if window_names[expectedWindows] == "null"
			    @selenium.select_window("name=#{window_names[1]}")
			else
			    @selenium.select_window("name=#{window_names[expectedWindows]}")
			end
		    rescue => e
			sleep(0.5)
		    # if exception continue
		    end
		else
		    done = false
		    for wait in 1..15 do
			begin
			    if @selenium.is_confirmation_present == true
				@selenium.choose_ok_on_next_confirmation
				@selenium.get_confirmation
			    end
			    window_names = @selenium.get_all_window_names()
			    #puts "Window Names: #{window_names}"
			    currentWindow = @selenium.get_eval("selenium.browserbot.getCurrentWindow().name")
			    #puts "Current Window1: " + currentWindow
			    if currentWindow != window_names[1]
				if window_names[1] == "null"
				    #continue
				else
				    @selenium.select_window("name=#{window_names[1]}")
				    done = true
				    break
				end
			    else
				if window_names[expectedWindows-1] == "null"
				    #continue
				else
				    @selenium.select_window("name=#{window_names[expectedWindows-1]}")
				    done = true
				    break
				end
			    end
			rescue => e
			    sleep(0.5)
			# if exception continue
			end
		    end
		    if done == false
			if @selenium.is_confirmation_present == true
			    @selenium.choose_ok_on_next_confirmation
			    @selenium.get_confirmation
			end
			#puts "Window1: #{window_names[window_names.length-1]}" 
			@selenium.select_window("name=#{window_names[window_names.length-1]}")
		    end
		end
	    else
		@selenium.open_window(url,"newWindow" + (expectedWindows-1).to_s)
		sleep(2)
		@selenium.select_window("newWindow" + (expectedWindows-1).to_s)
	    end
	end	
    end
end


