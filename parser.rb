require 'pry'
require 'date'

module FileParser

	def self.parse(file_location, separator)
		file   = File.open(file_location)
		raw_data   = extract_data(file, separator)
		list   = create_list_of_people(raw_data)
		people =  conform_list_data(list)
	end

	def self.save_to_file(file_location, person)
		info = [person.last_name.capitalize, person.first_name.capitalize, person.gender.capitalize, person.favorite_color.capitalize, person.date_of_birth.strftime('%m/%d/%Y').to_s]
		file = File.open(file_location, 'a') do |newline|
			newline.puts
			newline.write(info.join(', '))
		end
	end

	private

	def self.extract_data(file, separator)
		parsed_file = file.map do |row| 
			row.gsub(/\n/, '').split("#{separator}")
		end
		parsed_file
	end

	def self.create_list_of_people(data)
		header = data.shift
		people = data.map do |person|
			Person.new(Hash[header.zip(person)])
		end
		people
	end

	def self.conform_list_data(list)
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
			Date.strptime(string, "%m-%d-%Y")
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
