class DataKontak < ApplicationRecord
  belongs_to :user
  validates_associated :user
  validates :nama, presence: { message: 'Tidak Boleh Kosong' }
  validates :no_telp, presence: { message: 'Tidak Boleh Kosong' }, numericality: { only_integer: true, message: 'Harus Angka' }
end
