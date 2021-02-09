# frozen_string_literal: true

require 'rails_compatibility'
require 'rails_compatibility/active_record'

class << RailsCompatibility
  if ActiveRecord::Base.respond_to?(:attribute_types) # column_types was changed to attribute_types in Rails 5
    def attribute_types(klass)
      klass.attribute_types
    end
  elsif ActiveRecord::Base.respond_to?(:column_types) # Rails 4
    def attribute_types(klass)
      klass.column_types
    end
  else # In Rails 3
    def attribute_types(klass)
      klass.columns_hash
    end
  end
end
