class AddSpikeNameToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :spike_name, :string
  end
end
