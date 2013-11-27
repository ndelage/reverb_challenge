# if Display was nested inside a parent module like:
# AppName::Display then it would a fine name. But right now,
# Display is super generic (without the parent module it
# sounds like it's the Display for the entire world...)
#
# AppName::PersonDisplay might be another name (or something
# else that calls out how this is focused on the Person model
module Display

# There are tabs in the file. Convert them to spaces (check
# every other file as well.
	def self.map_records_to_attributes(list)
		list.map do |person|
			person.properties_for_person
		end
	end

	def self.map_records_to_hash_attributes(list)
		container = {}
		list.each_with_index do |person, index|
			container[index+1] = person.properties_for_person
		end
		container
	end

# this method name and the varible names are pretty vague.
# list? list of what?
	def self.print_records(list)
	  list.each do |person_array|
	    puts person_array.join(', ')
	  end
	end

end
