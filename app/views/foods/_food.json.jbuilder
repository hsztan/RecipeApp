json.extract! food, :id, :name, :unit, :price, :quantity, :created_at, :updated_at
json.url food_url(food, format: :json)
