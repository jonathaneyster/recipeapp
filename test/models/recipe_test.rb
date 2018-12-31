require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.new(name: "recipe", description: "description")
  end  
  
  test "valid" do
    assert @recipe.valid?
  end
end