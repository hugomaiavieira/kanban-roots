class TeamsController < InheritedResources::Base
  before_filter :authenticate_contributor!

  def manage_contributors
    @team = Team.find(params[:id])
  end

  def manage_projects
    @team = Team.find(params[:id])
  end
end

