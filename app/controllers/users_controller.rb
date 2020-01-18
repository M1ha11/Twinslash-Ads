class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %w[destroy update edit]
  load_and_authorize_resource

  def index
    if current_user && current_user.role == 'admin'
      @users = User.all.where.not(id: current_user.id)
    end
  end

  def destroy
    if current_user && current_user.role == 'admin'
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'Advertisement was successfully deleted' }
        format.json { head :no_content }
      end
    end
  end

  def edit
  end

  def update
    if current_user && current_user.role == 'admin'
      respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "User was successfully updated." }
        format.json { render :index, status: :ok }
      else
        flash[:errors] = @user.errors.full_messages
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :phone, :role)
  end
end
