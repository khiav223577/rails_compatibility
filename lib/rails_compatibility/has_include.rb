# frozen_string_literal: true

require 'rails_compatibility'
require 'rails_compatibility/active_record'

class << RailsCompatibility
  def has_include?(relation, column_name)
    relation.send(:has_include?, column_name)
  end
end
