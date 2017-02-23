class AddUserIdToDataKontaks < ActiveRecord::Migration[5.0]
  def change
    add_column :data_kontaks, :user_id, :integer
  end
end
