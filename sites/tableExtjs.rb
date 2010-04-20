require File.dirname(__FILE__) + '/element'

# Extjs Table object.
# Subclass of Element.
class Table_Extjs < Element
    def click
	@selenium.mouse_down(@locator)
        @selenium.click(@locator)
    end

    def cellText(rowNumber, columnNumber)
        #objectId = @selenium.get_attribute("#{@locator}@id")
        #//table[@id='#{table_id}']/tbody/tr
        rowNumber += 1
        for wait in 1..30 do
	    begin
	        cellText = @selenium.get_table("#{@locator}/div[2]/div[@class='x-grid3-body']/div[#{rowNumber}]/table.0.#{columnNumber}")
		if cellText != nil
                    break
                end
            rescue => e
                sleep(0.5)
            end
        end
        return cellText        
    end
    
#    def rowNumber(text)
#	table_id = 'table_id'
#	row_number = 0
#	@selenium.assign_id(@locator, table_id)
#	for wait in 1..60 do
#		begin
#		    object_id = @selenium.get_eval(locator)
#		    break
#		rescue => e
#		    sleep(0.5)
#		end
#	    end
#	@selenium.get_text("//div[@id='#{table_id}']/div[1]/div[2]/div/div[#{row_number}]")
#    end
end
