class Public::TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :task_image_destroy]

  def create
    @project = current_user.projects.find(params[:project_id])
    @task = @project.tasks.build(task_params)
    @task.user_id =  current_user.id
    if @task.save
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
  end

  def destroy
    @task.destroy
    flash[:notice] = "task destroyed"
    redirect_to project_path(@task.project)
  end

  def task_image_destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :task_image)
  end

end