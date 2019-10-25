class AdvertisementsController < ApplicationController
  before_action :authenticate_user!, only: %w[create update delete]
  before_action :set_advertisement, only: %w[show update destroy]

  def index
    @advertisements = Advertisement.all
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)
    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully created.' }
        format.json { render :show, status: :created, location: @advertisement }
      else
        format.html { render :new }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def update
    respond_to do |format|
      if @advertisement.update(advertisement_params)
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully updated.' }
        format.json { render :show, status: :ok, location: @advertisement }
      else
        format.html { render :edit }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @advertisement.destroy
    respond_to do |format|
      format.html { redirect_to advertisements_url, notice: 'Advertisement was successfully deleted' }
      format.json { head :no_content }
    end
  end

  private

  def set_advertisment
    @advertisement = Advertisement.find(params[:id])
  end

  def advertisment_params
    params.require(:advertisement).permit(:text, :status, :type)
  end
end
