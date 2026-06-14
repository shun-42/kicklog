class AddColumnsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :trap, :integer
    add_column :posts, :kick, :integer
    add_column :posts, :sprint, :integer
    add_column :posts, :pass_accuracy, :integer
    add_column :posts, :durability, :integer
  end
end
