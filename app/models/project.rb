class Project < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :tasks
  has_many :categories

  validates_presence_of :name

  def tasks_by_position position
    self.tasks.select {|item| item.position == position }
  end

  def clean_up_done_tasks
    done_tasks = self.tasks_by_position Board::DONE
    done_tasks.each { |task| task.update_attributes :position => Board::OUT }
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

