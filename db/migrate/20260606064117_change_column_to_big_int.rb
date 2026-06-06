class ChangeColumnToBigInt < ActiveRecord::Migration[8.0]
  def change 
    change_column :posts, :user_id, :bigint 
    change_column :posts, :brand_id, :bigint 
  end
end
