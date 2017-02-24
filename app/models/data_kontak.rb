class DataKontak < ApplicationRecord
  belongs_to :user
  validates_associated :user
  validates :nama, :alamat, :no_telp, :almt_email, presence: true
  validates :no_telp, numericality: { message: "Masukkan Angka" }
end
