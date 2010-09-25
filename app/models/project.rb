class Project < ActiveRecord::Base

  has_and_belongs_to_many :contributors

  validates_presence_of :name

end

