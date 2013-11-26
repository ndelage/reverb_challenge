require 'date'
require 'pry'
require_relative 'parser.rb'
require_relative 'display.rb'

class Records
	include FileParser
	include Display

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

	def order_by(*args)
		@data.sort_by do |person| 
			args.map { |arg| person.send(arg) }
		end
	end
end