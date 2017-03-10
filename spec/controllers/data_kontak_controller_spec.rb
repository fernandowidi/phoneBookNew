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

  it "GET new" do
    get :new, xhr: true
  end

  it "GET edit" do
    @data = build(:data)
    @data.save
    get :edit, params: { id: @data.id }, xhr: true
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
    end

    context "render new saat data invalid" do
      kontak_params = FactoryGirl.attributes_for(:data, no_telp: nil)
      subject { post :create, params: { kontak: kontak_params } }
      it { should render_template ('create') }
    end
  end

  describe "PUT update" do
    before (:each) do
      @data = build(:data)
      @data.save
    end

    context "valid attribute" do
      it "mencari data yang diminta" do
        put :update, params: { id: @data.id, kontak: FactoryGirl.attributes_for(:data) }
        assigns(:kontak).should eq(@data)
      end

      it "update nama" do
        put :update, params: { id: @data.id, kontak: FactoryGirl.attributes_for(:data, nama: "Ganet") }
        @data.reload
        @data.nama.should eq("Ganet")
      end

      it "update no telepon" do
        put :update, params: { id: @data.id, kontak: FactoryGirl.attributes_for(:data, no_telp: "008") }
        @data.reload
        @data.no_telp.should eq("008")
      end

      it "update alamat" do
        put :update, params: { id: @data.id, kontak: FactoryGirl.attributes_for(:data, alamat: "jojojojo") }
        @data.reload
        @data.alamat.should eq("jojojojo")
      end

      it "update email" do
        put :update, params: { id: @data.id, kontak: FactoryGirl.attributes_for(:data, almt_email: "blabla@yahoo.com") }
        @data.reload
        @data.almt_email.should eq("blabla@yahoo.com")
      end
    end

    context "invalid attribut" do
      it "nama kosong" do
        put :update, params: { id: @data.id, kontak: FactoryGirl.attributes_for(:data, nama: nil) }
        @data.reload
        @data.nama.should_not eq(nil)
      end

      it "no telepon kosong" do
        put :update, params: { id: @data.id, kontak: FactoryGirl.attributes_for(:data, no_telp: nil) }
        @data.reload
        @data.no_telp.should_not eq(nil)
      end
    end
    context "render edit" do
      subject { put :update, params: { id: @data.id, kontak: FactoryGirl.attributes_for(:data, nama: nil) } }
      it { should render_template 'update' }
    end
  end

  describe "DELETE destroy" do
    before (:each) do
      @data = build(:data)
      @data.save
    end

    it "hapus data kontak" do
      expect{
        delete :destroy, params: { id: @data.id }
      }.to change(DataKontak, :count).by(-1)
    end

    it "redirect ke index" do
      delete :destroy, params: { id: @data.id }
      expect {response}.should redirect_to root_path
    end
  end
end
