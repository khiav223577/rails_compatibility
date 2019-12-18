require 'test_helper'
require 'rails_compatibility/attribute_types'

class AttributeTypesTest < Minitest::Test
  def setup
  end

  def test_user
    expected_attribute_types = {
      'id'     => ActiveRecord::Type::Integer,
      'name'   => ActiveRecord::Type::String,
      'email'  => ActiveRecord::Type::String,
      'gender' => ActiveRecord::Type::String,
    }
    assert_equal expected_attribute_types, RailsCompatibility.attribute_types(User).transform_values(&:class)
  end
end
