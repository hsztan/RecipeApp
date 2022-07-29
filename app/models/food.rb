class Food < ApplicationRecord
  belongs_to :user

  has_many :food_recipes
  has_many :recipes, through: :food_recipes

  def self.food_to_buy(recipe: nil, user: nil) # rubocop:disable Metrics/CyclomaticComplexity
    ingredients = {}
    foods_clone = []
    recipe&.foods&.each { |food| foods_clone << food }

    recipe_food_quantities(recipe:, ingredients:, foods_clone:) if recipe

    if user
      user.recipes.includes([:foods]).each do |rec|
        rec.foods.each { |food| foods_clone << food }
      end
      recipe_food_quantities_all(ingredients:, user:, foods_clone:)
    end
    ingredients
  end

  def self.recipe_food_quantities_all(ingredients:, user:, foods_clone:)
    user.recipes.each do |recipe|
      ingredients.merge!(recipe_food_quantities(recipe:, ingredients:, foods_clone:))
    end
    ingredients
  end

  def self.recipe_food_quantities(recipe: nil, ingredients: nil, foods_clone: nil)
    recipe.food_recipes.includes([:food]).each_with_index do |food_recipe, idx|
      amount_to_buy = (foods_clone[idx].quantity || 0) - (food_recipe.quantity || 0)
      quantity = amount_to_buy.negative? ? amount_to_buy.abs : 0
      ingredients[food_recipe.food.name] = {
        quantity:,
        price: quantity * food_recipe.food.price,
        units: foods_clone[idx].unit
      }
      foods_clone[idx].quantity = amount_to_buy.negative? ? 0 : foods_clone[idx].quantity - amount_to_buy
    end
    ingredients
  end
end
