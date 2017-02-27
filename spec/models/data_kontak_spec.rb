require 'rails_helper'

RSpec.describe DataKontak, type: :model do
  ## pending "add some examples to (or delete) #{__FILE__}"
  it "data valid" do
    expect(build(:Data)).to be_valid
  end

  it "data tanpa nama" do
    expect(build(:Data, nama: nil)).to_not be_valid
  end

  it "data tanpa no" do
    expect(build(:Data, no_telp: nil)).to_not be_valid
  end

  it "data no selain angka" do
    expect(build(:Data, no_telp: numericality)).to_not be_valid
  end
end
