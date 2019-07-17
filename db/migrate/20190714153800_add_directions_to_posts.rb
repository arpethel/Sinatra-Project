class AddDirectionsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :directions, :string
  end
end
