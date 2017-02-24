class DataKontak < ApplicationRecord
  belongs_to :user
  validates_associated :user
  validates :nama, :alamat, :no_telp, :almt_email, presence: { message: "Tidak Boleh Kosong"}
  validates :no_telp, numericality: { message: "Masukkan Angka" }
end
