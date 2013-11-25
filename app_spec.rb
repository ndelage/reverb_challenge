require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.start

require_relative 'person.rb'
require_relative 'parser.rb'

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

describe FileParser do

  describe "#parse" do
    let(:parsed_file) { FileParser.parse('data_files/psv.txt',' | ') }

    it 'returns an array' do
      expect(parsed_file).to be_an(Array)
    end

    it 'returns an array of people objects' do
      expect(parsed_file.first).to be_an(Person)
    end

    it 'returns an array of people objects with accessible attributes' do
      expect(parsed_file.first.first_name).to eq('Steve')
    end

    it 'conforms date formats' do
      expect(parsed_file.first.date_of_birth).to be_an(Date)
    end

    it 'conforms gender formats' do
      expect(parsed_file.first.gender).to eq(('Male' || 'Female'))
    end
  end
end