class Contributor < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable

  # Setup accessible (or protected) attributes for your model (devise stuff)
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_and_belongs_to_many :projects
  has_and_belongs_to_many :tasks
  has_many :comments

  validates_presence_of :name

end

