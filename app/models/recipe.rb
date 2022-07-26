class Recipe < ApplicationRecord
  belongs_to :user
  # has many foods through food_recipes
  has_many :food_recipes
  has_many :foods, through: :food_recipes
end
