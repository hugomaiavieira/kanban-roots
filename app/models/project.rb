class Project < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :tasks

  validates_presence_of :name

  def tasks_by_position position
    self.tasks.select {|item| item.position == position }
  end

  def clean_up_done_tasks
    done_tasks = self.tasks_by_position Board::DONE
    done_tasks.each { |task| task.update_attributes :position => Board::OUT }
  end
end

