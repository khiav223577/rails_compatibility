# frozen_string_literal: true

require 'rails_compatibility'
require 'active_record'

class << RailsCompatibility
  if ActiveRecord::Base.respond_to?(:attribute_types)
    def attribute_types(klass)
      klass.attribute_types # column_types was changed to attribute_types in Rails 5
    end
  else
    def attribute_types(klass)
      klass.column_types
    end
  end
end
