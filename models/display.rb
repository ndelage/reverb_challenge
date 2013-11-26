module Display

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

	def self.print_records(list)
	  list.each do |person_array|
	    puts person_array.join(', ')
	  end
	end

end