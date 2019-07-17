class AddCooktimeAndChefToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :cooktime, :integer
    add_column :posts, :chef, :string
  end
end
