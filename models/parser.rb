require 'date'
require 'csv'
require_relative 'person.rb'

module FileParser

	def self.parse(file_location)
		people = []
		file = File.open(file_location)
		separator = find_separator(file)
    CSV.foreach(file, headers: true, header_converters: :symbol, col_sep: separator) do |row|
      people << Person.new(conform_data_set(row).to_hash)
	  end
	  people
	end

	def self.save_to_file(file_location, person)
		info = [person.last_name.capitalize, person.first_name.capitalize, person.gender.capitalize, person.favorite_color.capitalize, person.date_of_birth.strftime('%m/%d/%Y').to_s]
		file = File.open(file_location, 'a') do |newline|
			newline.puts
			newline.write(info.join(', '))
		end
	end

	def self.find_separator(file)
		if file.read.match(/\|/)
			" | "
		elsif file.read.match(/,/)
			", "
		else
			" "
		end	
	end

	def self.conform_data_set(data_from_file)
    	data_from_file[:dateofbirth] = conform_date_format(data_from_file[:dateofbirth])
    	data_from_file[:gender] = conform_gender_format(data_from_file[:gender])
    	data_from_file		
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
