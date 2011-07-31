class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Contributor'
  has_and_belongs_to_many :contributors
  has_many :tasks, :dependent => :destroy
  has_many :categories, :dependent => :delete_all

  validates_presence_of :name, :owner_id

  after_create :set_myself_as_project_of_my_owner

  def set_myself_as_project_of_my_owner
    contributor = Contributor.find(owner_id)
    contributor.projects << self
    contributor.save
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
      points = points.round(1) if not points.zero?
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
end

