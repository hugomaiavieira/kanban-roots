class Project < ActiveRecord::Base

  has_and_belongs_to_many :teams
  has_many :tasks

  validates_presence_of :name

  def tasks_by_position position
    # XXX: It is not tested!
    (self.tasks.collect { |item| item if item.position == position }).compact
  end
end

