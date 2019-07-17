class AddIngredientsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :ingredients, :string
  end
end
