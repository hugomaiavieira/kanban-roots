class Contributor < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable

  # Setup accessible (or protected) attributes for your model (devise stuff)
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_and_belongs_to_many :teams
  has_and_belongs_to_many :tasks

  validates_presence_of :name

end

