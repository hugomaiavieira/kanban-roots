class TasksController < InheritedResources::Base
  before_filter :authenticate_contributor!

  belongs_to :project

  def create
    create! { project_board_path }
  end

  def update
    update! { project_board_path }
  end

  def destroy
    destroy! { project_board_path }
  end
end

