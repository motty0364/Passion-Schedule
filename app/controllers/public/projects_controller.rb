class Public::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :image_destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def show
    @task = Task.new
    count = @project.tasks.where(progress: :complete).count
    total_count = @project.tasks.count
    if count.zero?
      @completion_rate = 0
    else
     @completion_rate = (count.to_f / total_count.to_f) * 100
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:notice] = "success"
      redirect_to project_path(@project)
    else
      flash.now[:alert] = "failed"
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "success"
      redirect_to project_path(@project)
    else
      flash.now[:alert] = "failed"
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = "project destroyed"
    redirect_to root_path
  end
#画像単体で削除更新される仕様を全編集完了時更新されるようにしたい
  def image_destroy
    @project.project_image.purge
    flash[:notice] = "image destroyed"
    redirect_to edit_project_path
  end

  private

  def set_project
    @project = Project.find_by(id: params[:id])
    redirect_to root_url if !@project
  end
  
  def correct_user
    if @project&.user != current_user
      redirect_to root_url
    end
  end


  def project_params
    params.require(:project).permit(:title, :description, :project_image)
  end
end
