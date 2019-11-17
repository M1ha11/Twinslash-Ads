class AdvertisementsController < ApplicationController
  before_action :authenticate_user!, only: %w[create update delete]
  before_action :set_advertisement, only: %w[show update destroy]
  load_and_authorize_resource

  def index
    @advertisements = Advertisement.all.where(state: :published)
    if current_user && current_user.role == 'user'
      @advertisements += current_user.advertisements
    end
  end

  def new
    @advertisement = current_user.advertisements.build
    # @advertisement = Advertisement.new
  end

  def create
    @advertisement = current_user.advertisements.build(advertisement_params)
    # @advertisement = Advertisement.new(advertisement_params)
    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully created.' }
        format.json { render :show, status: :created, location: @advertisement }
      else
        flash[:errors] = @advertisement.errors.full_messages
        format.html { render :new }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def update
    respond_to do |format|
      if @advertisement.state == "draft" && @advertisement.update(advertisement_params)
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully updated.' }
        format.json { render :show, status: :ok, location: @advertisement }
      else
        flash[:errors] = @advertisement.errors.full_messages
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

  def set_advertisement
    @advertisement = Advertisement.find(params[:id])
  end

  def advertisement_params
    params.require(:advertisement).permit(:text, :state, :type, :name, :image)
  end
end
