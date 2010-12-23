class Task < ActiveRecord::Base
  belongs_to :project

  CATEGORIES = ['Bug', 'Feature']
  POINTS = [0, 1, 2, 3, 5, 8, 13]

  validates_presence_of :title, :project
end

