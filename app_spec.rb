require 'rspec'
require 'pry'
require_relative 'person.rb'

describe Person do

  it 'has accessible attributes' do
  	person = Person.new({"FirstName" => 'Dain', 
                         "LastName" =>  'Hall',
                         "Gender" =>  'M',
                         "FavoriteColor" =>  'Blue', 
                         "DateOfBirth" =>  '2000-07-14'})
  	expect(person.first_name).to eq('Dain')
  end
end