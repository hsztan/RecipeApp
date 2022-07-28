Rails.application.routes.draw do
  root 'foods#index'
  resources :recipes
  resources :foods
  devise_for :users

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/public_recipes' => 'recipes#public_recipes'
  get '/shopping_list' => 'foods#shopping_list'
  post '/food_recipes/:id' => 'food_recipes#create', as: :food_recipes
  patch '/food_recipes/:id' => 'food_recipes#update', as: :food_recipe
  get '/recipes/:recipe_id/edit_ingredient/:food_id' => 'recipes#edit_ingredient', as: :edit_ingredient
  delete '/food_recipes/:id' => 'food_recipes#destroy'
  # root "articles#index"
end
