require 'rspec'
require 'pry'
require 'simplecov'
require 'rack/test'
SimpleCov.start

require_relative 'models/person.rb'
require_relative 'models/parser.rb'
require_relative 'models/records.rb'
require_relative 'driver.rb'
require_relative 'app_api.rb'

describe Person do

  it 'has accessible attributes' do
  	person = Person.new({firstname:'Dain', 
                         lastname: 'Hall',
                         gender: 'M',
                         dateofbirth: 'Blue', 
                         favoritecolor: '2000-07-14'})
  	expect(person.first_name).to eq('Dain')
  end
end

describe Records do

  describe '#get_data' do
    it 'returns an array' do
      expect(Records.get_data).to be_an(Array)
    end    

    it 'retrieves the relevant data from the data files' do
      # expect(Records.get_data).to be_an(Array)
    end
  end
end

describe FileParser do

  describe "#parse" do
    let(:parsed_file) { FileParser.parse('data_files/psv.txt') }

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

  describe '#save_to_file' do
    let(:file) { File.open('data_files/test.txt') }
    let(:person) { Person.new(firstname: "Test",
                              lastname: "McTester",
                              gender: "Female",
                              dateofbirth: Date.parse("2011-07-14"),
                              favoritecolor: "Blue") }
    
    it 'saves to the test file in csv format' do
      FileParser.save_to_file(file, person)
      file.read.should include(("McTester" && "Test" && "Male" && "Blue" && "07/14/2011"))
    end
  end
end

describe PersonParser::AppAPI do
  include Rack::Test::Methods

  def app
    PersonParser::AppAPI
  end

  describe PersonParser::AppAPI do
    
    describe "GET /records/all" do
      it "returns rendered records" do
        get "/records/all"
        last_response.status.should == 200
        JSON.parse(last_response.body).should include("1" => ["Smith", "Steve", "Male", "03/03/1985", "Red"])
      end
    end
  end
end


