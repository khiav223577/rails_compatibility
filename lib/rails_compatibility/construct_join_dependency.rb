# frozen_string_literal: true

require 'rails_compatibility'
require 'rails_compatibility/active_record'

class << RailsCompatibility
  if GTE_RAILS_6_0
    def construct_join_dependency(reflect, relation)
      joins = inverse_association_joins(reflect)
      return relation.construct_join_dependency(joins, Arel::Nodes::InnerJoin)
    end
  elsif GTE_RAILS_5_2
    def construct_join_dependency(reflect, relation)
      joins = inverse_association_joins(reflect)

      join_dependency = ActiveRecord::Associations::JoinDependency.new(reflect.klass, relation.table, joins)

      root = join_dependency.send(:join_root)

      join_dependency.instance_variable_set(:@alias_tracker, relation.alias_tracker)
      join_dependency.send(:construct_tables!, root)
      return join_dependency
    end
  else
    def construct_join_dependency(reflect, _relation)
      joins = inverse_association_joins(reflect)
      return ActiveRecord::Associations::JoinDependency.new(reflect.klass, joins, [])
    end
  end

  private

  def inverse_association_joins(reflect)
    [reflect.options[:inverse_of] || reflect.active_record.table_name]
  end
end
