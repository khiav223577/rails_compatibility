require 'test_helper'
require 'rails_compatibility/pick'

class UnscopeWhereTest < Minitest::Test
  def setup
    @females = User.where(gender: 'female')
    @males = User.where(gender: 'male')
  end

  def test_pick_single_column
    assert_equal 'Pearl', RailsCompatibility.pick(@females.order(:id), :name)
  end

  def test_pick_multiple_column
    assert_equal %w[Pearl female], RailsCompatibility.pick(@females.order(:id), :name, :gender)
    assert_equal %w[Peter male], RailsCompatibility.pick(@males.order(:id), :name, :gender)
  end

  def test_pick_with_offset
    assert_equal %w[Catty female], RailsCompatibility.pick(@females.offset(2).order(:id), :name, :gender)
    assert_nil RailsCompatibility.pick(@females.offset(999).order(:id), :name, :gender)
  end

  def test_pick_with_order
    assert_equal 'Catty', RailsCompatibility.pick(@females.order(name: :asc), :name)
    assert_equal 'Pearl', RailsCompatibility.pick(@females.order(name: :desc), :name)
  end

  def test_pick_none
    assert_nil RailsCompatibility.pick(@females.none, :name)
  end
end
