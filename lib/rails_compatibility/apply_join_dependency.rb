# frozen_string_literal: true

require 'rails_compatibility'
require 'rails_compatibility/active_record'

class << RailsCompatibility
  if GTE_RAILS_5_2
    def apply_join_dependency(relation)
      relation.send(:apply_join_dependency)
    end
  elsif GTE_RAILS_5_1
    def apply_join_dependency(relation)
      relation.send(:construct_relation_for_association_calculations)
    end
  elsif GTE_RAILS_5_0
    def apply_join_dependency(relation)
      relation.dup.send(:construct_relation_for_association_calculations)
    end
  else
    def apply_join_dependency(relation)
      relation.send(:construct_relation_for_association_calculations)
    end
  end
end
