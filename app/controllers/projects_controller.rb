class ProjectsController < InheritedResources::Base
  def manage_contributors
    @project = Project.find(params[:id])
  end
end

