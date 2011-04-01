class Project < ActiveRecord::Base
  has_and_belongs_to_many :teams, :before_remove => :remove_from_teams
  has_many :tasks, :dependent => :destroy
  has_many :categories, :dependent => :delete_all

  validates_presence_of :name

  def contributors
    project_list = []
    self.teams.each do |team|
      project_list << team.contributors
    end
    project_list.flatten
  end

  def contributors_scores
    list = []
    tasks = self.tasks_by_position Board::POSITIONS['done']

    self.contributors.each do |contributor|
      tasks_for_contributor = tasks.select { |task| task.contributors.include? contributor }
      points = 0
      tasks_for_contributor.each do |task|
        if task.points
          task.points.zero? ? points += 0.1 : points += task.points
        end
      end
      points = points.zero? ? 0 : points.round(1)
      list << { :contributor => contributor, :scores => points }
    end

    list.sort { |x, y| y[:scores] <=> x[:scores] }
  end

  def tasks_by_position position
    self.tasks.select {|item| item.position == position }
  end

  def clean_up_done_tasks
    done_tasks = self.tasks_by_position Board::POSITIONS['done']
    done_tasks.each { |task| task.update_attributes :position => Board::POSITIONS['out'] }
  end

  def count_points position
    points = 0
    self.tasks_by_position(position).each do |task|
      points += task.points if task.points
    end
    points
  end

  def <=> project
    self.name <=> project.name
  end

  def remove_from_teams(team)
    team.projects.delete(self)
    team.save
  end


end

