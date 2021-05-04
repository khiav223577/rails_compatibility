# frozen_string_literal: true

require 'rails_compatibility/active_record'

class << RailsCompatibility
  if GTE_RAILS_6_0
    def pick(relation, *args)
      relation.pick(*args)
    end
  elsif GTE_RAILS_4_0
    def pick(relation, *args)
      relation.limit(1).pluck(*args).first
    end
  else
    def pick(relation, *args)
      model = relation.first

      return nil if model == nil
      return model[args.first] if args.size == 1
      return args.map{|s| model[s] }
    end
  end
end
