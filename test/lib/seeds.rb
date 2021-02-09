ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, force: true do |t|
    t.string :name
    t.string :email
    t.string :gender
  end

  create_table :counties, force: true do |t|
    t.string :name, null: false
  end

  create_table :counties_zipcodes, force: true do |t|
    t.references :county, index: true, null: false
    t.references :zipcode, index: true, null: false
  end

  create_table :zipcodes, force: true do |t|
    t.string :zip, null: false
    t.string :city, null: false
  end
end

ActiveSupport::Dependencies.autoload_paths << File.expand_path('../models/', __FILE__)

users = User.create([
  { name: 'Peter', email: 'peter@example.com', gender: 'male' },
  { name: 'Pearl', email: 'pearl@example.com', gender: 'female' },
  { name: 'Doggy', email: 'kathenrie@example.com', gender: 'female' },
  { name: 'Catty', email: 'catherine@example.com', gender: 'female' },
])

County.create([
  {
    name: 'Fulton',
    zipcodes: [
      Zipcode.new(city: 'Atlanta', zip: '30301'),
      Zipcode.new(city: 'Union City', zip: '30291'),
    ],
  },
  {
    name: 'Hennepin',
    zipcodes: [
      Zipcode.new(city: 'Minneapolis', zip: '55410'),
      Zipcode.new(city: 'Edina', zip: '55416'),
    ],
  },
])
