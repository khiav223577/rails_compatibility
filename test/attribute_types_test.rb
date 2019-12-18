require 'test_helper'
require 'rails_compatibility/attribute_types'

class AttributeTypesTest < Minitest::Test
  def setup
  end

  def test_user
    assert_equal %w[id name email gender], RailsCompatibility.attribute_types(User).keys
  end
end
