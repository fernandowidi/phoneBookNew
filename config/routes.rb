Rails.application.routes.draw do
  devise_for :users
  resources :data_kontak
  get 'phonebook/index'
  get 'phonebook/dashboard'
  root 'phonebook#index'
  root 'phonebook#dashboard'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
