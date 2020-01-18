class AdvertisementsController < ApplicationController
  before_action :authenticate_user!, only: %w[create update destroy admin_index set_type]
  before_action :set_advertisement, only: %w[show update destroy set_type]
  # load_and_authorize_resource

  def index
    @advertisements = Advertisement.where(state: :published)
    @advertisements = @advertisements.paginate(page: params[:page], per_page: 9)
    if current_user && current_user.role == 'user'
      @advertisements += current_user.advertisements
    end
  end

  def new
    @advertisement = current_user.advertisements.build
    # @advertisement.images.build
    # @advertisement = Advertisement.new
  end

  def create
    @advertisement = current_user.advertisements.build(advertisement_params)
    # @advertisement = Advertadvertisementisement.new(advertisement_params)
    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to @advertisement, notice: 'Advertisement was successfully created.' }
        format.json { render :show, status: :created, location: @advertisement }
      else
        flash[:errors] = @advertisement.errors.full_messages
        format.html { render :new }
        format.json { render jdoson: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @advertisement.update(advertisement_params)
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


  def admin_index
    if current_user.role == 'admin'
      @advertisements = Advertisement.where(state: 'new').paginate(page: params[:page], per_page: 9)
    end
  end

  def set_type
    if current_user.role == 'admin'
      respond_to do |format|
        binding.pry
        if @advertisement.update(type_param)
          format.html { redirect_to @advertisement, notice: 'Advertisement was successfully updated.' }
          format.json { render :show, status: :ok, location: @advertisement }
        else
          flash[:errors] = @advertisement.errors.full_messages
          format.html { render :edit }
          format.json { render json: @advertisement.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def set_advertisement
    @advertisement = Advertisement.find(params[:id])
  end

  def type_param
    params.require(:advertisement).permit(:typ)
  end

  def advertisement_params
    params.require(:advertisement).permit(:text, :state, :name, :state_event, images: [])
  end
end
