class ProjectsController < InheritedResources::Base
  before_filter :authenticate_contributor!

  def create
    @project = Project.new(params[:project])
    @project.owner = Contributor.find(current_contributor.id)
    create!
  end

end

