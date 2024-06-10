class Public::HomesController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def top
    @user = current_user if current_user
    @projects = current_user.projects if current_user
  end

  def about
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "success"
      redirect_to edit_home_path
    else
      flash.now[:alert] = "failed"
      render :edit
    end
  end

  def destroy
    @user.image.purge
    flash[:notice] = "image destroyed"
    redirect_to edit_home_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :comment, :image)
  end

end
