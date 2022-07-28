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
    foods_clone = []
    recipe.foods.each do |food|
      foods_clone << food
    end
    recipe.food_recipes.each_with_index do |food_recipe, idx|
      amount = (food_recipe.quantity || 0) - (foods_clone[idx].quantity || 0)
      quantity = amount.positive? ? 0 : amount.abs
      ingredients[food_recipe.food.name] = {
        quantity:,
        price: quantity * food_recipe.food.price
      }
      foods_clone[idx].quantity = quantity.negative? ? 0 : quantity
    end
    ingredients
  end
end
