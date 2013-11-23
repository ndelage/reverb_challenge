require 'grape'
require 'json'
require_relative 'driver.rb'

# run 'rackup' from terminal - default port is 9292. Can set port with 'rackup -p <port_num>'
module Test
  class AppAPI < Grape::API

    version 'v1', using: :header, vendor: 'dain'
    format :json

  	desc 'home page'
  		get '/' do
  			"Hello"
  		end

    resources :records do

    	desc 'list all records'
	  		get '/all' do
	  			records = Records.get_data
	  			counter = 1
	  			object = {}
	  			records.each do |person|
	  				object[counter] = map_person_to_variable_names(person)
	  				counter += 1
	  			end
					return object
  			end

			desc 'list records sorted by gender & last name'
	  		get '/gender' do
	  			records = Records.get_data
	  			counter = 1
	  			object = {}
	  			sorted_records = records.sort_by { |person| [person.gender, person.last_name] }
	  			sorted_records.each do |person|
	  				object[counter] = map_person_to_variable_names(person)
	  				counter += 1
	  			end
					return object
  			end

  		desc 'list records sorted by birthdate'
	  		get '/birthdate' do
	  			records = Records.get_data
	  			counter = 1
	  			object = {}
	  			sorted_records = records.sort_by { |person| person.date_of_birth }
	  			sorted_records.each do |person|
	  				object[counter] = map_person_to_variable_names(person)
	  				counter += 1
	  			end
					return object
  			end

  		desc 'list records sorted by last name'
	  		get '/name' do
	  			records = Records.get_data
	  			counter = 1
	  			object = {}
	  			sorted_records = records.sort_by { |person| person.last_name }.reverse
	  			sorted_records.each do |person|
	  				object[counter] = map_person_to_variable_names(person)
	  				counter += 1
	  			end
					return object
  			end

  		end
  	end
end