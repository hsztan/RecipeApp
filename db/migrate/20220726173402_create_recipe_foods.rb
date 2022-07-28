class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :food_recipes do |t|
      t.belongs_to :recipe
      t.belongs_to :food
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end


