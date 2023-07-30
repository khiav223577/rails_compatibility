# frozen_string_literal: true

require 'test_helper'
require 'rails_compatibility/cast_values'

class CastValuesTest < Minitest::Test
  def setup
  end

  def test_cast_values
    sql = 'SELECT `users`.`name` FROM `users` WHERE `users`.`name` = "Peter" LIMIT 1'
    result = ActiveRecord::Base.connection.select_all(sql)
    assert_equal ['name' => 'Peter'], RailsCompatibility.cast_values(User, result)
  end
end
