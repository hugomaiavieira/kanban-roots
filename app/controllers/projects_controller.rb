class ProjectsController < InheritedResources::Base
  actions :all, :except => [ :index, :show ]

  before_filter :authenticate_contributor!

  def create
    @project = Project.new(params[:project])
    @project.owner = Contributor.find(current_contributor.id)
    create! { project_board_path(@project) if @project.errors.empty? }
  end

  def update
    update! { project_board_path(@project) }
  end
end

