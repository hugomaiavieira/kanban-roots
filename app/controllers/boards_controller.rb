class BoardsController < InheritedResources::Base
  actions :show

  def show
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end
end

