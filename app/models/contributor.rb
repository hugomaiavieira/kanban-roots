class Contributor < ActiveRecord::Base

  has_and_belongs_to_many :teams

  validates_presence_of :name, :email
  validates_format_of :email,
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

end

