class CreateDataKontaks < ActiveRecord::Migration[5.0]
  def change
    create_table :data_kontaks do |t|
      t.string :nama
      t.string :alamat
      t.string :no_telp
      t.string :almt_email

      t.timestamps
    end
  end
end
