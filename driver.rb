require_relative 'parser.rb'
require_relative 'person.rb'

p Records.get_data.map_to_variable_names

# p 'Output 1:'
# array.each do |person|
# 	print person.first_name,
# 		  person.last_name, 
# 		  person.gender, 
# 		  person.date_of_birth, 
# 		  person.favorite_color
# end
