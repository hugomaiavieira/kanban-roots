class BoardsController < InheritedResources::Base
  before_filter :authenticate_contributor!

  actions :show

  def show
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end

  def clean_up_done
    @project = Project.find(params[:project_id])
    @project.clean_up_done_tasks
    flash[:notice] = 'Done division was cleaned up.'
    redirect_to :action => :show, :project_id => @project.id
  end
end

