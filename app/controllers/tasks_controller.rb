class TasksController < InheritedResources::Base
  belongs_to :project

  def create
    create! { project_board_path }
  end

  def update
    update! { project_board_path }
  end
end

