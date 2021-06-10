# frozen_string_literal: true

require 'rails_compatibility'
require 'rails_compatibility/active_record'

class << RailsCompatibility
  if GTE_RAILS_6_1
    def has_include?(relation, column_name)
      relation.send(:has_include?, column_name)
    end
  elsif GTE_RAILS_5_0
    def has_include?(relation, column_name)
      relation.dup.send(:has_include?, column_name)
    end
  else
    def has_include?(relation, column_name)
      relation.send(:has_include?, column_name)
    end
  end
end
