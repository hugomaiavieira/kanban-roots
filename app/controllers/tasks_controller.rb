class TasksController < InheritedResources::Base
  before_filter :authenticate_contributor!

  belongs_to :project

  def show
    show! do
      @project = @task.project
      @comment = Comment.new
    end
  end

  def new
    new! { @categories = Category.where(:project_id => @project.id) }
  end

  def edit
    edit! { @categories = Category.where(:project_id => @project.id) }
  end

  def create
    params[:task][:author_id] = current_contributor.id
    create! { project_board_path }
  end

  def update
    update! { project_board_path }
  end

  def destroy
    destroy! { project_board_path }
  end

end

