require File.dirname(__FILE__) + '/element'

# Basic Table object.
# Subclass of Element.
class Table < Element
    
    def getRowNumber(text)
	table_id = 'table_id'    
	@selenium.assign_id(@locator, table_id)	
	row_count = @selenium.get_xpath_count("//table[@id='#{table_id}']/tbody/tr")
	rowNumber = 1
	found = false
	for wait in 1..row_count.to_i do
	    begin
		rowText = @selenium.get_text("//table[@id='#{table_id}']/tbody/tr[#{rowNumber}]")
		if /#{text}/.match(rowText)
		    found = true
		    break
		else
		    rowNumber += 1
		end		
	    rescue => e
		rowNumber += 1
	    end
	end
	
	if found == true
	    return rowNumber-1
	else
	    puts "Table id: #{table_id}"
	    puts "Rowcount: #{row_count}"
	    puts "Rownumber: #{rowNumber}"
	    fail "Table RowNumber not found!"
	end	
    end
    
    def cellText(rowNumber, columnNumber)
	@selenium.get_table("#{@locator}.#{rowNumber}.#{columnNumber}")
    end
    
    def tableRowCount
	table_id = 'table_id'    
	@selenium.assign_id(@locator, table_id)	
	row_count = @selenium.get_xpath_count("//table[@id='#{table_id}']/tbody/tr")
	return row_count
    end
end

