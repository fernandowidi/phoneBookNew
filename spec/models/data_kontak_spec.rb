require 'rails_helper'

RSpec.describe DataKontak, type: :model do
  ## pending "add some examples to (or delete) #{__FILE__}"
  it "data valid" do
    expect(build(:Data)).to be_valid
  end

  it "data tanpa nama" do
    expect(build(:Data, nama: nil)).to_not be_valid
  end

  it "data tanpa no telepon" do
    expect(build(:Data, no_telp: nil)).to_not be_valid
  end

  it "data no telepon selain angka" do
    expect(build(:Data, no_telp: 'sasa')).to_not be_valid
  end

  it { should belong_to (:user) }
end
