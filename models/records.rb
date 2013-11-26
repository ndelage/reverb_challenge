require 'pry'
require 'date'
require_relative 'parser.rb'

class Records
	include FileParser

	def initialize(*args)
		@data = get_data(*args)
	end

	def get_data(*args)
		file_data = []
		args.each do |file| 
			file_data << FileParser.parse(file) 
		end
		file_data.flatten
	end

	def map_list_to_attributes
		map do |person|
			properties_for_person(person)
		end
	end

	def properties_for_person(person)
	  [person.last_name, person.first_name, person.gender, person.date_of_birth.strftime('%m/%d/%Y').to_s, person.favorite_color]
	end

	def convert_records_to_display(records)
		counter = 1
		object = {}
		records.each do |person|
			object[counter] = Records.properties_for_person(person)
			counter += 1
		end
		return object
	end

	def order_by(*args)
		self.sort_by do |person| 
			args.each do |field| 
				person.send(field.to_sym)
			end
		end
	end
end