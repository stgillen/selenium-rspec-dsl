require File.dirname(__FILE__) + '/element'

# Link object used when multiple window or popups occur after clicking.
# Subclass of Element.
class LinkMultiWindow < Element
    # Clicks on object, waits for expectedWindows count and then selects new window.
    def click(expectedWindows=1, useHref=true)
	
	if expectedWindows == 1
	    @selenium.click(@locator)
	    @selenium.select_window "null"
	    sleep(3)
	    @selenium.wait_for_condition("selenium.browserbot.getCurrentWindow()", TIMEOUT)
	else
	    begin
		id = @selenium.get_attribute("#{@locator}@id")
		#onclickEvent = @selenium.get_eval("window.document.getElementById('#{id}').onclick")
		url = @selenium.get_eval("window.document.getElementById('#{id}').href")
		if /javascript.doPopUp/.match(url)
		    url = "null"
		end
		if useHref == false
		    url = "null"
		end
	    rescue => e
		url = "null"
	    end

		#puts expectedWindows
		#windows = @selenium.get_all_window_ids()
		#n = 0
		#while n < windows.length
		#    puts "id: " + windows[n]
		#    n += 1
		#end
		#
		#windows2 = @selenium.get_all_window_names()
		#n = 0
		#while n < windows2.length
		#    puts "name: " + windows2[n]
		#    n += 1
		#end
		#
		#windows3 = @selenium.get_all_window_titles()
		#n = 0
		#while n < windows3.length
		#    puts "title: " + windows3[n]
		#    n += 1
		#end
				  
	    if url == "null"
		windows = @selenium.get_all_window_ids()
		
		#puts expectedWindows
		#n = 0
		#while n < windows.length
		#    puts "id: " + windows[n]
		#    n += 1
		#end
		#
		#windows2 = @selenium.get_all_window_names()
		#n = 0
		#while n < windows2.length
		#    puts "name: " + windows2[n]
		#    n += 1
		#end
		#
		#windows3 = @selenium.get_all_window_titles()
		#n = 0
		#while n < windows3.length
		#    puts "title: " + windows3[n]
		#    n += 1
		#end
		
		@selenium.click(@locator)
		
		for wait in 1..20 do
		    windows = @selenium.get_all_window_ids()		    
		    if expectedWindows != windows.length
			sleep(0.5)
		    else
			break
		    end
		end	
		#puts expectedWindows
		#n = 0
		#while n < windows.length
		#    puts "id: " + windows[n]
		#    n += 1
		#end
		#
		#windows2 = @selenium.get_all_window_names()
		#n = 0
		#while n < windows2.length
		#    puts "name: " + windows2[n]
		#    n += 1
		#end
		#
		#windows3 = @selenium.get_all_window_titles()
		#n = 0
		#while n < windows3.length
		#    puts "title: " + windows3[n]
		#    n += 1
		#end
		
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
		    for wait in 1..10 do
			begin
			    window_names = @selenium.get_all_window_names()
			    currentWindow = @selenium.get_eval("selenium.browserbot.getCurrentWindow().name")
			    #puts "Current Window: " + currentWindow
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
			@selenium.select_window("name=#{window_names[1]}")
		    end
		end
	    else
		
		@selenium.open_window(url,"newWindow" + (expectedWindows-1).to_s)
		@selenium.select_window("name=newWindow" + (expectedWindows-1).to_s)
	    end
	end
    end
end


