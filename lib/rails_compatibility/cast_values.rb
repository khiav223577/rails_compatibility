# frozen_string_literal: true

require 'rails_compatibility'
require 'rails_compatibility/active_record'
require 'rails_compatibility/deserialize'

class << RailsCompatibility
  if Gem::Version.new(ActiveRecord::VERSION::STRING) >= Gem::Version.new('7.0.6')
    # Rails 7.0.6 changes parameter handling. Details at: https://github.com/rails/rails/pull/45783
    def cast_values(klass, result)
      attribute_types = self.attribute_types(klass)

      result.map do |attributes| # This map behaves different to array#map
        attributes.each_with_index do |(key, attribute), index|
          attributes[key] = deserialize(result.send(:column_type, key, index, attribute_types), attribute)
        end

        next attributes
      end
    end
  elsif GTE_RAILS_4_0
    def cast_values(klass, result)
      attribute_types = self.attribute_types(klass)

      result.map do |attributes| # This map behaves different to array#map
        attributes.each do |key, attribute|
          attributes[key] = deserialize(result.send(:column_type, key, attribute_types), attribute)
        end

        next attributes
      end
    end
  else
    def cast_values(klass, result)
      result.map! do |attributes| # This map! behaves different to array#map!
        initialized_attributes = klass.initialize_attributes(attributes)
        attributes.each do |key, _attribute|
          attributes[key] = klass.type_cast_attribute(key, initialized_attributes)
        end

        next attributes
      end
    end
  end
end
