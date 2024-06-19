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
      redirect_to root_path
    else
      flash.now[:alert] = "failed"
      render :edit
    end
  end
#画像単体で削除更新される仕様を全編集完了時更新されるように
  def destroy
    @user.profile_image.purge
    flash[:notice] = "image destroyed"
    redirect_to edit_home_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :comment, :profile_image)
  end

end
