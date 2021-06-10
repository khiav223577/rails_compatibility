require 'test_helper'
require 'rails_compatibility/has_include'

class HasIncludeTest < Minitest::Test
  def setup
    @posts = Post.limit(1).includes(:user)
  end

  def test_not_become_immutable
    assert_equal true, RailsCompatibility.has_include?(@posts, :id)
    assert_equal false, @posts.where!(id: nil).exists?
  end
end
