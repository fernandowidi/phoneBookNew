class DataKontakController < ApplicationController
  # respond_to :html, :js
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @kontaks = DataKontak.accessible_by(current_ability)
  end

  def edit
    @kontak = DataKontak.find(params[:id])
  end

  def new
    @kontak = DataKontak.new
  end

  def update
    @kontak = DataKontak.find(params[:id])
    respond_to do |format|
      format.js
      if @kontak.update(kontak_params)
        render js: "window.location='#{root_path}'"
      else
        format.html { render 'edit' }
      end
    end
  end

  def create
    @kontak = DataKontak.new(kontak_params)
    respond_to do |format|
      format.js
      if @kontak.save
        render js: "window.location='#{root_path}'"
      else
        format.html { render 'new' }
      end
    end
  end

  def destroy
    @kontak = DataKontak.find(params[:id])
    @kontak.destroy
    redirect_to root_path
  end

  private
    def kontak_params
      params.require(:kontak).permit(:nama, :alamat, :no_telp, :almt_email, :user_id)
    end
end
