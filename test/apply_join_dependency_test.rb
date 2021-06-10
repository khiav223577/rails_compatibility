require 'test_helper'
require 'rails_compatibility/apply_join_dependency'

class ApplyJoinDependencyTest < Minitest::Test
  def setup
    skip if ActiveRecord::VERSION::MAJOR < 4 # Rails 3's includes + pluck will not become left outer joins
    @posts = Post.includes(:user)
  end

  def test_not_become_immutable
    RailsCompatibility.apply_join_dependency(@posts)

    assert_equal false, @posts.where!(id: nil).exists?
  end

  def test_pluck_with_includes
    assert_equal 'SELECT "posts".* FROM "posts"', @posts.to_sql

    @posts = RailsCompatibility.apply_join_dependency(@posts)
    assert_equal 'SELECT "posts".* FROM "posts" LEFT OUTER JOIN "users" ON "users"."id" = "posts"."user_id"', @posts.to_sql
  end
end
