# frozen_string_literal: true

require 'rails_compatibility'
require 'rails_compatibility/active_record'

class << RailsCompatibility
  if GTE_RAILS_6_0
    def construct_join_dependency(reflect, relation)
      association_joins = [reflect.active_record.table_name]
      return relation.construct_join_dependency(association_joins, Arel::Nodes::InnerJoin)
    end
  elsif GTE_RAILS_5_2
    def construct_join_dependency(reflect, relation)
      association_joins = [reflect.active_record.table_name]

      join_dependency = ActiveRecord::Associations::JoinDependency.new(reflect.klass, relation.table, association_joins)

      root = join_dependency.send(:join_root)

      join_dependency.instance_variable_set(:@alias_tracker, relation.alias_tracker)
      join_dependency.send(:construct_tables!, root)
      return join_dependency
    end
  else
    def construct_join_dependency(reflect, _relation)
      association_joins = [reflect.active_record.table_name]
      return ActiveRecord::Associations::JoinDependency.new(reflect.klass, association_joins, [])
    end
  end
end
