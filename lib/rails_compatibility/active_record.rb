# frozen_string_literal: true

require 'rails_compatibility'
require 'active_record'

module RailsCompatibility
  GTE_RAILS_6_1 = Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new('6.1.0')
  GTE_RAILS_6_0 = Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new('6.0.0')
  GTE_RAILS_5_2 = Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new('5.2.0')
  GTE_RAILS_5_1 = Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new('5.1.0')
  GTE_RAILS_5_0 = Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new('5.0.0')
  GTE_RAILS_4_0 = Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new('4.0.0')
end
