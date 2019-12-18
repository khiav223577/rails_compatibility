require 'test_helper'
require 'rails_compatibility/attribute_types'

class AttributeTypesTest < Minitest::Test
  def setup
  end

  def test_user
    expected_attribute_types = {
      'id'     => :integer,
      'name'   => :string,
      'email'  => :string,
      'gender' => :string,
    }
    assert_equal expected_attribute_types, RailsCompatibility.attribute_types(User).transform_values(&:type)
  end
end
