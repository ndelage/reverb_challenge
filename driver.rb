require 'pry'
require_relative 'models/records.rb'

def print_records(list)
  list.each do |person_array|
    joined_line = person_array.join(', ')
    puts joined_line 
  end
end

records = Records.new('data_files/psv.txt', 'data_files/csv.txt', 'data_files/ssv.txt')

puts '----------------'
puts "Output 1:"
sorted_records = records.order_by("gender", "last_name")
print_records(sorted_records.map_list_to_attributes)
puts '----------------'
puts "Output 2:"
sorted_records = records.sort_by { |person| person.date_of_birth }
print_records(Records.map_list_to_attributes(sorted_records))
puts '----------------'
puts "Output 3:"
sorted_records = records.sort_by { |person| person.last_name }.reverse
print_records(Records.map_list_to_attributes(sorted_records))