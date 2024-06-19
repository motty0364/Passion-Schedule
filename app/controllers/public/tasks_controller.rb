class Public::TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :task_image_destroy]
  before_action :set_project, only: [:show, :create, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def show
    @child_tasks = @task.child_tasks
    @parent_tasks = @task.parent_tasks
    @task_relationship = TaskRelationship.new
    @no_relation_tasks = current_user.tasks.where.not(id: @task.id) - @parent_tasks - @child_tasks
  end

  def create
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
    if @task.update(task_params)
      flash[:notice] = "success"
      redirect_to project_path(@project)
    else
      flash.now[:alert] = "failed"
      render :new
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "task destroyed"
    redirect_to project_path(@task.project_id)
  end

  def task_image_destroy
    @task.task_image.purge
    flash[:notice] = "image destroyed"
    redirect_to edit_project_task_path
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
    redirect_to root_url if !@task
  end

  def set_project
    @project = current_user.projects.find_by(id: params[:project_id])
    redirect_to root_url if !@project
  end
  
  def correct_user
    if @task&.user != current_user
      redirect_to root_url
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :task_image, :progress)
  end

end