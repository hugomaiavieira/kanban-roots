class TasksController < InheritedResources::Base
  belongs_to :project

  def create
    create! { project_board_path }
  end
end

