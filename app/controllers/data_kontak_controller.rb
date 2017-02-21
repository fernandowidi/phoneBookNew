class DataKontakController < ApplicationController
  def index
    @kontaks = DataKontak.all
  end

  def show
    @kontak = DataKontak.find(params[:id])
  end
  
  def new
    @kontak = DataKontak.new
  end

  def create
    @kontak = DataKontak.new(kontak_params)

    @kontak.save
    redirect_to @kontak
  end

  private
    def kontak_params
      params.require(:kontak).permit(:nama, :alamat, :no_telp, :almt_email)
    end
end
