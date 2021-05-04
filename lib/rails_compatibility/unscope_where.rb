# frozen_string_literal: true

require 'rails_compatibility/active_record'

class << RailsCompatibility
  if GTE_RAILS_4_0
    def unscope_where(relation)
      relation.unscope(:where)
    end
  else
    def unscope_where(relation)
      relation.dup.tap{|s| s.where_values = [] }
    end
  end
end
