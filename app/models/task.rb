class Task < ActiveRecord::Base

  CATEGORIES = ['Bug', 'Feature']
  POINTS = [0, 1, 2, 3, 5, 8, 13]

  validates_presence_of :title

end

