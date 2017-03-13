class DataKontakController < ApplicationController
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
      if @kontak.update(kontak_params)
        format.html { redirect_to root_path }
        format.js { render js: "window.location='#{root_path}'" }
      else
        format.html { render 'edit' }
        format.js
      end
    end
  end

  def create
    @kontak = current_user.data_kontak.new(kontak_params)
    respond_to do |format|
      if @kontak.save
        format.html { redirect_to root_path }
        format.js { render js: "window.location='#{root_path}'" }
      else
        format.html { render 'new' }
        format.js
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
      params.require(:kontak).permit(:nama, :alamat, :no_telp, :almt_email)
    end
end
