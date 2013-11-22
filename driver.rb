require 'pry'
require_relative 'parser.rb'
require_relative 'person.rb'

def map_to_variable_names(list)
	list.map do |person|
		[person.last_name, person.first_name, person.gender, person.date_of_birth.strftime('%m/%d/%Y').to_s, person.favorite_color]
	end
end

def print_records(list)
  list.each do |person_array|
    joined_line = person_array.join(', ')
    puts joined_line 
  end
end

records = Records.get_data

puts '----------------'
puts "Output 1:"
sorted_records = records.sort_by { |person| [person.gender, person.last_name] }
print_records(map_to_variable_names(sorted_records))
puts '----------------'
puts "Output 2:"
sorted_records = records.sort_by { |person| person.date_of_birth }
print_records(map_to_variable_names(sorted_records))
puts '----------------'
puts "Output 3:"
sorted_records = records.sort_by { |person| person.last_name }.reverse
print_records(map_to_variable_names(sorted_records))