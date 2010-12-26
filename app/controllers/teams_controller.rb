class TeamsController < InheritedResources::Base
  def manage_contributors
    @team = Team.find(params[:id])
  end

  def manage_projects
    @team = Team.find(params[:id])
  end
end

