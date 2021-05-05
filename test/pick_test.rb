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
    assert_equal 'Catty', RailsCompatibility.pick(@females.order('name ASC'), :name)
    assert_equal 'Pearl', RailsCompatibility.pick(@females.order('name DESC'), :name)

    if ActiveRecord::VERSION::MAJOR >= 4 # Order with hash parameters only available in ActiveRecord >= 4.0
      assert_equal 'Catty', RailsCompatibility.pick(@females.order(name: :asc), :name)
      assert_equal 'Pearl', RailsCompatibility.pick(@females.order(name: :desc), :name)
    end
  end

  def test_pick_none
    skip if ActiveRecord::VERSION::MAJOR < 4 # Rails 3 doesn't support none
    assert_nil RailsCompatibility.pick(@females.none, :name)
  end

  def test_pick_no_data
    assert_nil RailsCompatibility.pick(@females.where('1=0'), :name)
  end
end
