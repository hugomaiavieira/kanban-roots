class Task < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :contributors

  CATEGORIES = ['Bug', 'Feature', 'Refactoring']
  POINTS = [0, 1, 2, 3, 5, 8, 13]

  validates_presence_of :title, :project
end

