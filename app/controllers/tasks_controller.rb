class TasksController < InheritedResources::Base
  before_filter :authenticate_contributor!

  belongs_to :project

  def new
    new! {@categories = Category.where(:project_id => @project.id) }
  end

  def edit
    edit! {@categories = Category.where(:project_id => @project.id) }
  end

  def create
    create! { project_board_path }
  end

  def update
    update! { project_board_path }
  end

  def destroy
    destroy! { project_board_path }
  end

  # TODO: Make test
  def update_position
    task = Task.find(params[:id])
    task.update_attribute(:position, Board::POSITIONS[params[:position]])
    return
  end
end

