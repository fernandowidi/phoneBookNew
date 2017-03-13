require 'rails_helper'

RSpec.feature "DataKontaks", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  before (:each) do
    @user = FactoryGirl.create(:ability, :adm)
    # Capybara.reset_sessions!
  end

  def login
    login_as(@user, :scope => :user, :run_callbacks => false)
  end

  def call_modal_new
    login
    visit (root_path)
    click_link ('New Contact')
  end

  def create_data
    @data = FactoryGirl.build(:data)
    @data.save
  end

  describe "login" do
    it "sukses" do
      visit (root_path)
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
      click_button ('login_button')
      expect(page).to have_content "Signed in successfully."
      # save_and_open_page
    end

    it "gagal" do
      visit (root_path)
      fill_in 'user_email', :with => ''
      fill_in 'user_password', :with => @user.password
      click_button ('login_button')
      expect(page).to have_content "Invalid Email or password."
      # save_and_open_page
    end
  end

   it 'log out' do
     login
     visit (root_path)
     click_link ('Logout')
     expect(page).to have_content "You need to sign in or sign up before continuing."
     # save_and_open_page
   end

   describe 'sign up' do
     it 'sukses' do
       visit (new_user_registration_path)
       click_link ('Sign Up')
       fill_in 'user_email', :with => 'koplak@test.com'
       fill_in 'user_password', :with => 'aksjdhasjdhaskdhas'
       fill_in 'user_password_confirmation', :with => 'aksjdhasjdhaskdhas'
       click_button ('sign_up_button')
       expect(page).to have_content "Welcome! You have signed up successfully."
       # save_and_open_page
     end

     it 'gagal karena email kosong' do
       visit (new_user_registration_path)
       click_link ('Sign Up')
       fill_in 'user_email', :with => ''
       fill_in 'user_password', :with => 'aksjdhasjdhaskdhas'
       fill_in 'user_password_confirmation', :with => 'aksjdhasjdhaskdhas'
       click_button ('sign_up_button')
       expect(page).to have_content 'Email can\'t be blank'
       # save_and_open_page
     end

     it 'gagal karena password kosong' do
       visit (new_user_registration_path)
       click_link ('Sign Up')
       fill_in 'user_email', :with => 'test@test.com'
       fill_in 'user_password', :with => ''
       fill_in 'user_password_confirmation', :with => ''
       click_button ('sign_up_button')
       expect(page).to have_content 'Password can\'t be blank'
       # save_and_open_page
     end

     it 'gagal karena email sudah ada' do
       visit (new_user_registration_path)
       click_link ('Sign Up')
       fill_in 'user_email', :with => @user.email
       fill_in 'user_password', :with => ''
       fill_in 'user_password_confirmation', :with => ''
       click_button ('sign_up_button')
       expect(page).to have_content 'Email has already been taken'
       # save_and_open_page
     end

     it 'gagal karena password konfirmasi tidak sama' do
       visit (new_user_registration_path)
       click_link ('Sign Up')
       fill_in 'user_email', :with => @user.email
       fill_in 'user_password', :with => @user.password
       fill_in 'user_password_confirmation', :with => 'fernandowidi'
       click_button ('sign_up_button')
        # save_and_open_page
       expect(page).to have_content 'Password confirmation doesn\'t match Password'
     end
   end

   describe 'tambah kontak baru' do
     it 'sukses', :js => true do
       call_modal_new
       within('#form-modal') do
         fill_in 'kontak_nama', :with => 'fernando'
         fill_in 'kontak_no_telp', :with => '0822222'
         fill_in 'kontak_alamat', :with => 'mojo 3/16'
         fill_in 'kontak_almt_email', :with => 'fernando@test.com'
         click_button ('Simpan')
       end
        # save_and_open_page
       expect(page).to have_content 'fernando'
     end

     it 'gagal karena nama kosong' do
       call_modal_new
       within('#form-modal') do
         fill_in 'kontak_nama', :with => nil
         fill_in 'kontak_no_telp', :with => '0822222'
         fill_in 'kontak_alamat', :with => 'mojo 3/16'
         fill_in 'kontak_almt_email', :with => 'fernando@test.com'
         click_button ('Simpan')
       end
       expect(page).to have_content 'Nama Tidak Boleh Kosong'
       # save_and_open_page
     end

     it 'gagal karena no telepon kosong' do
       call_modal_new
       within('#form-modal') do
         fill_in 'kontak_nama', :with => 'fernando'
         fill_in 'kontak_no_telp', :with => nil
         fill_in 'kontak_alamat', :with => 'mojo 3/16'
         fill_in 'kontak_almt_email', :with => 'fernando@test.com'
         click_button ('Simpan')
       end
       expect(page).to have_content 'No telp Tidak Boleh Kosong'
       binding.pry
      #  # save_and_open_page
     end

     it 'gagal karena no telepon bukan angka' do
       call_modal_new
       within('#form-modal') do
         fill_in 'kontak_nama', :with => 'fernando'
         fill_in 'kontak_no_telp', :with => 'ando'
         fill_in 'kontak_alamat', :with => 'mojo 3/16'
         fill_in 'kontak_almt_email', :with => 'fernando@test.com'
         click_button ('Simpan')
       end
       expect(page).to have_content 'No telp Harus Angka'
       # save_and_open_page
     end
   end

   it 'edit kontak', :js => true do
     login
     create_data
     visit (root_path)
     click_link ('Edit')
     within('#edit-modal') do
      fill_in 'kontak_nama', :with => 'jumbo'
      click_button ('Simpan')
     end
     expect(page).to have_content 'jumbo'
     # save_and_open_page
   end

   it 'hapus data kontak' do
     login
     create_data
     visit (root_path)
     click_link ('Hapus')
     expect(page).to_not have_content 'fernando'
     # save_and_open_page
   end
end
