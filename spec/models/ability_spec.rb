require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  describe "User" do
    subject(:ability){ Ability.new(user) }

    context "admin" do
      let(:user){ build(:ability, :adm) }
      it{ should be_able_to(:manage, DataKontak.new) }
    end

    context "user" do
      let(:user){ build(:ability, :usr) }
      it{ should be_able_to(:crud, DataKontak.new(:user_id => user.id)) }
    end
  end
end
