# Modify the CSV application to support an each method to return a CsvRow object.
# Use method_missing on that CsvRow to return the value for the column for a given heading.
# For example, for the file:

# one, two
# lions, tigers

# allow an API that works like this:

# csv = RubyCsv.new
# csv.each {|row| puts row.one}

# This should print "lions".
module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  class CsvRow
    attr_accessor :headers, :row_data

    def initialize(headers, row_data)
      @headers = headers
      @row_data = row_data
    end

    def method_missing(name, *args, &block)
      heading = name.to_s
      if @headers.include?(heading)
        index = @headers.index(heading)
        @row_data[index]
      else
        super
      end
    end
  end
  
  module InstanceMethods   
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end
    
    def each(&block)
      @csv_contents.each do |row_data|
        yield CsvRow.new(@headers, row_data)
      end
    end

    attr_accessor :headers, :csv_contents
    def initialize
      read 
    end
  end
end

class RubyCsv
  include ActsAsCsv
  acts_as_csv
end

# m = RubyCsv.new
# puts m.headers.inspect
# puts m.csv_contents.inspect

csv = RubyCsv.new
csv.each {|row| puts row.one}
