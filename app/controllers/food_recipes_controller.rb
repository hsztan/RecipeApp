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
    @food_recipe.recipe = Recipe.find(params[:id])
    @food_recipe.save
    redirect_to recipe_url(@food_recipe.recipe)
  end

  def update
    @food = Food.new(food_params)
    @food.user = current_user
    @food.save
    @food_recipe = FoodRecipe.find(params[:id])
    @food_recipe.update(food_recipe_params)
    redirect_to recipe_url(@food_recipe.recipe)
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @food_recipe = FoodRecipe.find(params[:id])
    @food_recipe.destroy
    redirect_to recipe_url(@food_recipe.recipe)
  end

  private

  def food_recipe_params
    params.require(:food_recipe).permit(:quantity)
  end

  def food_params
    params.require(:food_recipe).permit(:name, :unit, :price)
  end
end
