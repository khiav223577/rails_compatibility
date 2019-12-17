require 'test_helper'
require 'rails_compatibility/unscope_where'

class UnscopeWhereTest < Minitest::Test
  def setup
    @females = User.where(gender: 'female')
    @males = User.where(gender: 'male')
  end

  def test_unscope
    assert_equal 4, RailsCompatibility.unscope_where(@females).count
    assert_equal 1, @males.count
    assert_equal 3, @females.count
  end

  def test_unscope_and_where
    assert_equal 1, RailsCompatibility.unscope_where(@females).where(gender: 'male').count
    assert_equal 1, @males.count
    assert_equal 3, @females.count
  end
end
