class CommentsController < InheritedResources::Base

  belongs_to :task

  def create
    create! { redirect_to(project_task_path(@comment.task.project, @comment.task)) and return }
  end

  def update
    update! { redirect_to(project_task_path(@comment.task.project, @comment.task)) and return }
  end

  def destroy
    destroy! { redirect_to(project_task_path(@comment.task.project, @comment.task)) and return }
  end

end

