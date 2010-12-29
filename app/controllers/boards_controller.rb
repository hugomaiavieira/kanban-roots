class BoardsController < InheritedResources::Base
  before_filter :authenticate_contributor!

  actions :show

  def show
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end
end

