# frozen_string_literal: true

require 'rails_compatibility'
require 'rails_compatibility/construct_join_dependency'
require 'rails_compatibility/active_record'

class << RailsCompatibility
  def build_joins(reflect, relation)
    join_dependency = construct_join_dependency(reflect, relation)

    if GTE_RAILS_6_1
      joins = join_dependency.join_constraints([], relation.alias_tracker, relation.references_values)
      return joins
    elsif GTE_RAILS_6_0
      joins = join_dependency.join_constraints([], relation.alias_tracker)
      return joins
    elsif GTE_RAILS_5_2
      joins = join_dependency.join_constraints([], Arel::Nodes::InnerJoin, relation.alias_tracker)
      return joins
    elsif GTE_RAILS_5_0
      info = join_dependency.join_constraints([], Arel::Nodes::InnerJoin)[0]
      return info.joins
    elsif GTE_RAILS_4_0
      info = join_dependency.join_constraints([])[0]
      return info.joins
    else
      return join_dependency.join_associations
    end
  end
end
