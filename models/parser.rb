require 'pry'
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
    # where's the best place to format (e.g. capitalize)?
		info = [person.last_name.capitalize, person.first_name.capitalize, person.gender.capitalize, person.favorite_color.capitalize, person.date_of_birth.strftime('%m/%d/%Y').to_s]
		file = File.open(file_location, 'a') do |newline|
      # what's this empty puts for?
			newline.puts
			newline.write(info.join(', '))
		end
	end

	def self.find_separator(file)
    # do you know what .read does?
		file_content = file.read
		if file_content.include?("|")
			" | "
		elsif file_content.include?(",")
			", "
		else
			" "
		end	
	end

	def self.conform_data_set(data)
    	data[:dateofbirth] = conform_date_format(data[:dateofbirth])
    	data[:gender] = conform_gender_format(data[:gender])
    	data		
	end

	def self.conform_date_format(date_string)
		if date_string.match(/\//)
			Date.strptime(date_string, "%m/%d/%Y")
		elsif date_string.match(/-/)
			Date.strptime(date_string, "%m-%d-%Y")
		end
	end

	def self.conform_gender_format(gender_string)
		if gender_string.match(/^(m|M)/)
			"Male"
		elsif gender_string.match(/^(f|F)/)
			"Female"
		end
	end

end
