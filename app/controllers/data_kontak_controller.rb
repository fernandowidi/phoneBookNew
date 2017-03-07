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

    if @kontak.update(kontak_params)
      redirect_to root_path
    else
      redirect_to 'edit'
    end
  end

  def create
    @kontak = DataKontak.new(kontak_params)

    if @kontak.save
      redirect_to root_path
    else
      redirect_to 'new'
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
