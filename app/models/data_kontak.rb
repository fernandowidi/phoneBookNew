class DataKontak < ApplicationRecord
  belongs_to :user
  validates_associated :user
  validates :nama, presence: true
  validates :no_telp, presence: true, numericality: true
end
