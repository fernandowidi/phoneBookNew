class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action :store_action

  def store_action
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?)
        store_location_for(:user, data_kontak_index_path)
    end
  end
end
