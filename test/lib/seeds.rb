ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, force: true do |t|
    t.string :name
    t.string :email
    t.string :gender
  end
end

ActiveSupport::Dependencies.autoload_paths << File.expand_path('../models/', __FILE__)

users = User.create([
  { name: 'Peter', email: 'peter@example.com', gender: 'male' },
  { name: 'Pearl', email: 'pearl@example.com', gender: 'female' },
])
