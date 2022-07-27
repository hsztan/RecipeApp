class Food < ApplicationRecord
  belongs_to :user

  has_many :food_recipes
  has_many :recipes, through: :food_recipes

  def self.recipe_food_quantities_all(user)
    ingredients = {}
    user.recipes.each do |recipe|
      ingredients.merge!(recipe_food_quantities(recipe))
    end
    ingredients
  end

  def self.recipe_food_quantities(recipe)
    ingredients = {}
    recipe.food_recipes.each do |food_recipe|
      quantity = (food_recipe.quantity || 0) - (food_recipe.food.quantity || 0)
      ingredients[food_recipe.food.name] = {
        quantity:,
        price: quantity * food_recipe.food.price
      }
    end
    ingredients
  end
end
