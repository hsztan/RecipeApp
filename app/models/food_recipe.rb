class FoodRecipe < ApplicationRecord
  belongs_to :food
  belongs_to :user
end
