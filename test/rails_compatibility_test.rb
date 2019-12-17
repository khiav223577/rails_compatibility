require 'test_helper'

class RailsCompatibilityTest < Minitest::Test
  def setup
  end

  def test_that_it_has_a_version_number
    refute_nil ::RailsCompatibility::VERSION
  end
end
