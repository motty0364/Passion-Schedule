class Public::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :image_destroy]

  def show
    @task = Task.new
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
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :project_image)
  end
end
