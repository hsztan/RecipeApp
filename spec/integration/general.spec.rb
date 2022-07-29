require 'rails_helper'

RSpec.describe 'FoodItems', type: :feature do
  before(:each) do
    @user = User.new(
      name: 'Test User',
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
    @user.confirmed_at = Time.now
    @user.skip_confirmation!
    @user.save!
    sign_in @user

    (1..5).each do |id|
      Food.create(
        name: "Food #{id}",
        unit: 'kgs',
        price: 2.5,
        quantity: 1000,
        user_id: @user.id
      )
    end

    @recipe = Recipe.create(name: 'Test Recipe', user_id: @user.id, description: 'Test Description', cooking_time: 10,
                            preparation_time: 5)

    Food.all.each do |food|
      RecipeFood.create(quantity: 2, recipe_id: recipe.id, food_id: food.id)
    end
  end

  it 'should show the food list' do
    visit food_path
    expect(page).to have_content('Food 1')
    expect(page).to have_content('Food 2')
    expect(page).to have_content('Food 3')
    expect(page).to have_content('Food 4')
    expect(page).to have_content('Food 5')
  end
end
