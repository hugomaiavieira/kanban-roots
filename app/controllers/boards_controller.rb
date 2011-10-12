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
      task_points = score = 0
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

    position = Board::POSITIONS.key(task.position)
    if position != 'done'
      score = 0
    else
      # TODO: refactor
      if task.points.nil?
        old_points = 0
      elsif task.points.zero?
        old_points = 0.1
      else
        old_points = task.points
      end
      if points.nil?
        new_points = 0
      elsif points.to_i.zero?
        new_points = 0.1
      else
        new_points = points.to_i
      end
      score = new_points - old_points
    end

    task.update_attribute(:points, points)

    project = Project.find(task.project_id)
    division_name = Board::POSITIONS[params[:division_id]]
    division_points = project.count_points(division_name)
    contributors = task.contributor_ids
    data = { :division_points => division_points, :contributors => contributors, :score => score}
    render :text => data.to_json
  end

  # TODO: Make test and refactor
  # Fazer com que o '-' apareça selecionado caso n tenha nenhum contributor
  def update_assignees
    task = Task.find(params[:task_id])
    params[:assignees].delete '-'
    params[:assignees] = nil if params[:assignees].empty?
    task.update_attribute(:contributor_ids, params[:assignees])
    assignees_sentence = params[:assignees].nil? ? '-' : task.contributors.collect(&:username).to_sentence

    if assignees_sentence.length > 25
      long_sentence = true
      assignees_long_sentence = assignees_sentence
      assignees_sentence = assignees_sentence.truncate(25)
    end

    data = { :assignees_sentence => assignees_sentence, :long_sentence => long_sentence, :assignees_long_sentence => assignees_long_sentence }
    render :text => data.to_json
  end
end

