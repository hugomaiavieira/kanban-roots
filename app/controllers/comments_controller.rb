class CommentsController < InheritedResources::Base

  actions :new, :create, :update, :destroy

  belongs_to :task

  def create
    create! { redirect_to(project_task_path(@comment.task.project, @comment.task)) and return }
  end

end

