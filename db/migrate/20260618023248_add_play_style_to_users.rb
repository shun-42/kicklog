class AddPlayStyleToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :play_style, :string
  end
end
