# frozen_string_literal: true

require 'rails_compatibility'
require 'rails_compatibility/active_record'

class << RailsCompatibility
  if GTE_RAILS_5_0
    # type_cast_from_database was changed to deserialize in Rails 5
    def deserialize(type, attribute)
      type.deserialize(attribute)
    end
  else
    def deserialize(type, attribute)
      type.type_cast_from_database(attribute)
    end
  end
end
