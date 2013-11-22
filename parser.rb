require 'pry'
require 'date'

module FileParser

	def self.parse(file_location, separator)
		file   = open_file(file_location)
		data   = parse_data(file, separator)
		list   = map_data_to_list(data)
		people =  clean_list_data(list)
	end

	private

	def self.open_file(file_location)
		file = File.open(file_location)
	end

	def self.parse_data(file, separator)
		parsed_file = file.map do |row| 
			row.gsub(/\n/, '').split("#{separator}")
		end
		parsed_file
	end

	def self.map_data_to_list(data)
		header = data.shift
		people = data.map do |person|
			Person.new(Hash[header.zip(person)])
		end
		people
	end

	def self.clean_list_data(list)
		list.each do |person|
			person.date_of_birth = conform_date_format(person.date_of_birth)
			person.gender = conform_gender_format(person.gender)
		end
		list
	end

	def self.conform_date_format(string)
		if string.match(/\//)
			Date.strptime(string, "%m/%d/%Y")
		elsif string.match(/-/)
			Date.parse(string)
		end
	end

	def self.conform_gender_format(string)
		if string.match(/^(m|M)/)
			"Male"
		elsif string.match(/^(f|F)/)
			"Female"
		end
	end
end
