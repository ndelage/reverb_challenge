require 'pry'
require 'date'

class Person
	attr_accessor :first_name, :last_name, :date_of_birth, :gender, :favorite_color

	def initialize(params)
		@first_name     = params.fetch(:firstname)
		@last_name      = params.fetch(:lastname)
		@date_of_birth  = params.fetch(:dateofbirth)
		@gender 		= params.fetch(:gender)
		@favorite_color = params.fetch(:favoritecolor)
	end
end