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
