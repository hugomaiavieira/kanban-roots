class CommentsController < InheritedResources::Base
  actions :all, :except => [ :show ]

  before_filter :authenticate_contributor!
  belongs_to :task

  def edit
    edit! {
      unless current_contributor == @comment.contributor
        redirect_to(project_task_path(@comment.task.project, @comment.task)) and return
      end
      @project = @task.project
    }
  end

  def new
    new! { @project = @task.project }
  end

  def create
    create! { project_task_path(@comment.task.project, @comment.task) }
  end

  def update
    update! { project_task_path(@comment.task.project, @comment.task) }
  end

  def destroy
    destroy! { project_task_path(@comment.task.project, @comment.task) }
  end

end

