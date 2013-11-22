require 'pry'
require 'date'
require_relative 'parser.rb'

class Person
	attr_accessor :first_name, :last_name, :date_of_birth, :gender, :favorite_color

	def initialize(params)
		@first_name     = params["FirstName"]
		@last_name      = params["LastName"]
		@date_of_birth  = params["DateOfBirth"]
		@gender 		= params["Gender"]
		@favorite_color = params["FavoriteColor"]
	end
end

class Records
	include FileParser

	def self.get_data
		data = []
		data << FileParser.parse('data_files/psv.txt',' | ')
		data << FileParser.parse('data_files/csv.txt',', ')
		data << FileParser.parse('data_files/ssv.txt',' ')
		data.flatten
	end

	# def map_to_variable_names(list)
	# 	list.map do |person|
	# 		person.first_name + person.last_name + person.date_of_birth + person.gender + person.favorite_color
	# 	end
	# end

	# def sort(variable)
	# end
end