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
  post '/food_recipes/recipe/:recipe_id' => 'food_recipes#create', as: :food_recipes
  # root "articles#index"
end
