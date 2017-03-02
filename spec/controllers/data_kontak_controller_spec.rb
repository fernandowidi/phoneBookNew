require 'rails_helper'

RSpec.describe DataKontakController, type: :controller do
  before{
    allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource){nil}
  }
  before(:each) do
    @user = build(:ability, :adm)
    @user.save
    sign_in @user
    request.headers["accept"] = 'application/javascript'
  end

  it "GET index" do
    get :index
  end

  describe "POST create" do
    context "valid attribute" do
      it "membuat data phonebook" do
        kontak_params = FactoryGirl.attributes_for(:data)
        expect { post :create, params: { kontak: kontak_params } }.to change(DataKontak, :count).by(1)
      end
    end
    context "invalid attribute" do
      it "field nama kosong" do
        kontak_params = FactoryGirl.attributes_for(:data, nama: nil)
        expect { post :create, params: { kontak: kontak_params } }.to change(DataKontak, :count).by(0)
      end
      it "field no telepon kosong" do
        kontak_params = FactoryGirl.attributes_for(:data, no_telp: nil)
        expect { post :create, params: { kontak: kontak_params } }.to change(DataKontak, :count).by(0)
      end
      it "field no telepon selain angka" do
        kontak_params = FactoryGirl.attributes_for(:data, no_telp: 'ahsgd')
        expect { post :create, params: { kontak: kontak_params } }.to change(DataKontak, :count).by(0)
      end
      context "render new saat data invalid" do
        kontak_params = FactoryGirl.attributes_for(:data, no_telp: nil)
        subject { post :create, params: { kontak: kontak_params } }
        it { should render_template (:new) }
      end
    end
  end
end
