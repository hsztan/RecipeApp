class Food < ApplicationRecord
  has_many :recipes, through: :recipe_foods
end
