class Recipe < ApplicationRecord
  has_many :foods, through: :recipe_foods
end
