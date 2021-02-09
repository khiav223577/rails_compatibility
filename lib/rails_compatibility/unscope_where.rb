# frozen_string_literal: true

require 'rails_compatibility/active_record'

class << RailsCompatibility
  if ActiveRecord::VERSION::MAJOR < 4
    def unscope_where(relation)
      relation.dup.tap{|s| s.where_values = [] }
    end
  else
    def unscope_where(relation)
      relation.unscope(:where)
    end
  end
end
