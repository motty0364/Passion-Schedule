class Public::TaskRelationshipsController < ApplicationController
  def create
    @task_relationship = TaskRelationship.new(task_relationship_params)
    @task_relationship.save if @task_relationship.parent_task_id != @task_relationship.child_task_id
    redirect_back(fallback_location: root_url)
  end
  
  def destroy
    @task = Task.find(params[:task_id])
    if params[:parent_task_id].present?
      @task_relationship = TaskRelationship.find_by(child_task_id: params[:task_id], parent_task_id: params[:parent_task_id])
    elsif params[:child_task_id].present?
      @task_relationship = TaskRelationship.find_by(child_task_id: params[:child_task_id], parent_task_id: params[:task_id])
    end
    @task_relationship.destroy if @task_relationship
    redirect_to project_task_path(@task.project, @task)
  end
  
  private
  
  def task_relationship_params
    params.require(:task_relationship).permit(:parent_task_id, :child_task_id)
  end
end
