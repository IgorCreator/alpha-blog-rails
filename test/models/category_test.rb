require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "SpoRts")
    @category.save
  end

  test "category should not be case sensitive" do
    assert_equal('sports', @category.name)
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save
    @category2 = Category.new(name: "sports")
    assert_not @category2.valid?
  end

  test "name should not be too short" do
    @category.name = "or"
    assert_not @category.valid?
  end

  test "name should not be too long" do
    @category.name = "very long name for testing. unreal long name"
    assert_not @category.valid?
  end

end
