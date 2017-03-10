class AddUserIdToDataKontaks < ActiveRecord::Migration[5.0]
  def change
    add_column :data_kontaks, :user_id, :integer
    add_foreign_key :data_kontaks, :user
  end
end
