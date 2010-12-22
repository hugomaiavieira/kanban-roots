class Task < ActiveRecord::Base
  belongs_to :project
  # XXX: The positions should be on Board Model
  POSITIONS = ['Backlog', 'To Do', 'Doing', 'Done']
  CATEGORIES = ['Bug', 'Feature']
  POINTS = [0, 1, 2, 3, 5, 8, 13]

  validates_presence_of :title, :project
end

