class Project < ActiveRecord::Base

  has_and_belongs_to_many :teams
  has_many :tasks

  validates_presence_of :name

end

