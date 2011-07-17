class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :category
  has_and_belongs_to_many :contributors
  has_many :comments, :dependent => :delete_all

  POINTS = [0, 1, 2, 3, 5, 8, 13]

  validates_presence_of :title, :project_id
end

