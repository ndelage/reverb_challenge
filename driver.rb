require 'pry'
require_relative 'models/records.rb'
require_relative 'models/display.rb'

records = Records.new('data_files/psv.txt', 'data_files/csv.txt', 'data_files/ssv.txt')

puts '----------------'
puts "Output 1:"
sorted_records = records.order_by("gender", "last_name")
Display.print_records(Display.map_records_to_attributes(sorted_records))
puts '----------------'
puts "Output 2:"
sorted_records = records.order_by("date_of_birth", "last_name")
Display.print_records(Display.map_records_to_attributes(sorted_records))
puts '----------------'
puts "Output 3:"
sorted_records = records.order_by("last_name").reverse
Display.print_records(Display.map_records_to_attributes(sorted_records))
