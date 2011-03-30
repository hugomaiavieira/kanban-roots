class BoardsController < InheritedResources::Base
  before_filter :authenticate_contributor!

  actions :show

  def show
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
    @categories = Category.where(:project_id => @project.id).order(:name)
  end

  def clean_up_done
    @project = Project.find(params[:project_id])
    @project.clean_up_done_tasks
    flash[:notice] = 'Done division was cleaned up.'
    redirect_to :action => :show, :project_id => @project.id
  end

  # TODO: Make test and refactor
  def update_position
    task = Task.find(params[:task_id])

    old_position = Board::POSITIONS.key(task.position)
    contributors = task.contributor_ids

    if task.points.nil?
      task_points = 0
      score = 0
    else
      task_points = task.points
      score = task.points.zero? ? 0.1 : task.points
      if old_position == 'done'
        score = -score
      elsif params[:new_position] != 'done'
        score = 0
      end
    end

    task.update_attribute(:position, Board::POSITIONS[params[:new_position]])

    data = { :old_position => old_position, :task_points => task_points, :score => score, :contributors => contributors }
    render :text => data.to_json
  end

  # TODO: Make test and refactor
  def update_points
    task = Task.find(params[:task_id])
    points = params[:points] == '-' ? nil : params[:points]
    task.update_attribute(:points, points)
    render :nothing => true
  end

  # TODO: Make test and refactor
  # Fazer com que o '-' apareça selecionado caso n tenha nenhum contributor
  def update_sponsors
    task = Task.find(params[:task_id])
    params[:sponsors].delete '-'
    params[:sponsors] = nil if params[:sponsors].empty?
    task.update_attribute(:contributor_ids, params[:sponsors])
    sponsors_sentence = params[:sponsors].nil? ? '-' : task.contributors.collect(&:name).to_sentence

    if sponsors_sentence.length > 25
      long_sentence = true
      sponsors_long_sentence = sponsors_sentence
      sponsors_sentence = sponsors_sentence.truncate(25)
    end

    data = { :sponsors_sentence => sponsors_sentence, :long_sentence => long_sentence, :sponsors_long_sentence => sponsors_long_sentence }
    render :text => data.to_json
  end
end

