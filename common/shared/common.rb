module Common
  
  def pageUrl
    self.waitForPage
    for wait in 1..40 do
      begin
        url = @selenium_driver.get_location
        if url == nil
          sleep(0.5)
        else
          break
        end
      rescue => e
        #continue
      end
    end          
    return url
  end
  
  def goToURL(url)
    @selenium_driver.open(url)
    @selenium_driver.wait_for_page_to_load
  end
  
  def waitForPage
    @selenium_driver.wait_for_page_to_load
  end
  
  def waitForText(text, attempts=40)
    for wait in 1..attempts do
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
  
  def wait_for_multi_windows(numOfExpectedWindows)
    #sleep(2)
    for wait in 1..40 do
      windows = @selenium_driver.get_all_window_ids()        
      if numOfExpectedWindows != windows.length
        sleep(0.5)
      else
        break
      end
    end
    
    for wait in 1..10 do
      begin
        window_names = @selenium_driver.get_all_window_names()
        @selenium_driver.select_window("name=#{window_names[numOfExpectedWindows-1]}")
        break
      rescue => e
        sleep(0.5)
        # if exception continue
      end
    end
  end

  def wait_for_multi_windows_titles(numOfExpectedWindows)
    #sleep(2)
    for wait in 1..40 do
      windows = @selenium_driver.get_all_window_titles()        
      if numOfExpectedWindows != windows.length
        sleep(0.5)
      else
        break
      end
    end
    
    #windows1 =  @selenium_driver.get_all_window_ids()
    #n = 0
    #while n < windows1.length
    #    puts "id: " + windows1[n]
    #    n += 1
    #end
    #
    #windows2 =  @selenium_driver.get_all_window_names()
    #n = 0
    #while n < windows2.length
    #    puts "name: " + windows2[n]
    #    n += 1
    #end
    #
    #windows3 =  @selenium_driver.get_all_window_titles()
    #n = 0
    #while n < windows3.length
    #    puts "title: " + windows3[n]
    #    n += 1
    #end
    
    for wait in 1..10 do
      begin
        window_titles = @selenium_driver.get_all_window_titles()
        @selenium_driver.select_window("title=#{window_titles[numOfExpectedWindows-1]}")
        break
      rescue => e
        sleep(0.5)
        # if exception continue
      end
    end
  end
  
  def put_focus_on_parent_window
    @selenium_driver.select_window "null"
  end
  
  def close_window
    @selenium_driver.close
  end
  
  def remove_all_browser_cookies
    @selenium_driver.delete_all_visible_cookies
  end
  
  def refresh_browser
    @selenium_driver.window_focus
    @selenium_driver.refresh
    self.waitForPage
    #sleep(4)
    #@selenium_driver.wait_for_condition("selenium.browserbot.getCurrentWindow()", TIMEOUT)
  end
  
  def dragDrop(object_to_be_dragged, object_dragged_to)
    #@selenium_driver.drag_and_drop_to_object(object_to_be_dragged, object_dragged_to)
    @selenium_driver.mouse_down(object_to_be_dragged)
    @selenium_driver.mouse_move(object_dragged_to)
    @selenium_driver.mouse_up(object_to_be_dragged)
  end
  
  def isTextPresent(text)
    return @selenium_driver.is_text_present(text)
  end

  def maximize_browser
    @selenium_driver.window_maximize
  end
  
  def clickFirefoxResendButton
    sleep(3)
    @selenium_driver.key_press_native(10)
    @selenium_driver.window_focus
  end
  
  def answerFirefoxConfirmation
    sleep(2)
    @selenium_driver.get_confirmation
  end

  def pageTitle
    return @selenium_driver.get_title
  end
  
  def controlKeyDown
    @selenium_driver.control_key_down
  end
  
  def controlKeyUp
    @selenium_driver.control_key_up
  end
end
