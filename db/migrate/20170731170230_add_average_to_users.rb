class AddAverageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :average, :integer
  end
end
