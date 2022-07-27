class FoodRecipesController < ApplicationController
  def create
    @food = Food.find_by(name: food_params[:name], user: current_user)
    if @food.nil?
      @food = Food.new(food_params)
      @food.user = current_user
      @food.save
    end
    # Add the food to the recipe
    @food_recipe = FoodRecipe.new(food_recipe_params)
    @food_recipe.food = @food
    @food_recipe.recipe = Recipe.find(params[:recipe_id])
    @food_recipe.save
    redirect_to recipe_url(@food_recipe.recipe)
  end

  private

  def food_recipe_params
    params.require(:food).permit(:quantity)
  end

  def food_params
    params.require(:food).permit(:name, :unit, :price, :recipe_id)
  end
end
