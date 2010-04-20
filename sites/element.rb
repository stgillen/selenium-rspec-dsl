# Parent Class of all objects
class Element
    # When initialized, waits for object to become present before proceding,
    # if object does appear before wait time, test will fail.  
    def initialize(selenium, locator, parent_id=nil)
	if @@TEST_FAILURE === true
	    fail "Step failed, due to previous step failing!"
	end
	
	object_id = nil
	found = false
	@selenium = selenium
	
	# check to see if selenium_driver has been passed to element level from spec
	begin
	    @selenium.host
	rescue => e    
	    fail "Error occurred: @selenium_driver not in element level"
	end	
	
	if parent_id != nil
	    for wait in 1..60 do
		begin
		    parent_id = @selenium.get_eval(parent_id)
		    break
		rescue => e
		    sleep(0.5)
		end
	    end
	    locator = locator.gsub('<EnterParentID>', parent_id)
	end

	for wait in 1..60 do
	    begin
		# if statement used for objects with mulitple locator
		if locator.is_a?(Array) == true
		    count = 0
		    while count <= locator.length and found == false
			if /.browserbot/.match(locator[count])
			    for wait in 1..60 do
				begin
				    object_id = @selenium.get_eval(locator)
				    found = true
				    break
				rescue => e
				    sleep(0.5)
				end
			    end				
			elsif @selenium.is_element_present(locator[count]) == false
			    sleep(0.5)
			    found = false
			    count += 1
			else
			    found = true
			    @locator = locator[count]
			    break
			end
		    end
		else
		    if /.browserbot/.match(locator)
			for wait in 1..60 do
			    begin
				object_id = @selenium.get_eval(locator)
				found = true
				break
			    rescue => e
				sleep(0.5)
			    end
			end
		    elsif @selenium.is_element_present(locator) == false
			sleep(0.5)
			#puts "looking for object: #{locator}"
			found = false
		    else
			found = true
			#puts "found object: #{locator}"
			@locator = locator
			break
		    end
		end
	    rescue => e
	    # if exception continue
	    end
	end
	
	if found == false
	    @@TEST_FAILURE = true
	    fail "Step Failed - Object not found!"
	end

	@object_id = object_id	
    end
    
    def waitForText(text)
	for wait in 1..20 do
	    begin
		if not @selenium_driver.is_text_present(text)
		    sleep(0.5)
		else
		    break
		end
	    rescue => e
	    # if exception continue
	    end
	end
    end
    # returns text content of object  
    def text
	if @object_id != nil
	    @text = @selenium.get_text(@object_id)
	else
	    for wait in 1..20 do
		begin
		    @text = @selenium.get_text(@locator)
		    break
		rescue => e
		    sleep(0.5)
		end
	    end
	end
	return @text
    end
    
    # returns value of object
    def value
	@value = @selenium.get_value(@locator)
	return @value
    end
    
    # clicks on object
    def click
	@selenium.click(@locator)
	#@selenium.wait_for_page_to_load
    end
    
    def hover
	@selenium.mouse_over(@locator)
    end

    # returns true or false if object is visible
    def visible
	@visible = @selenium.is_visible(@locator)
	return @visible
    end
    
    # returns true, no code needed, because initializing of object performs
    # wait for object is present
    def exist
	return true
    end
    
    def qtipValue
	return @selenium.get_eval("selenium.browserbot.findElement('#{@locator}').attributes[0].value")
    end
    
    def locator
	return @locator
    end
    
    # double clicks on object
    def doubleClick
	@selenium.double_click(@locator)
    end

    def attribute(type)
	return @selenium.get_attribute("#{@locator}@#{type}")
    end
    
    def rightClick
	@selenium.context_menu(@locator)
    end
end
