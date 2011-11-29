class Contributor < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # Setup accessible (or protected) attributes for your model (devise stuff)
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me,
                  :username, :login

  has_many :own_projects, :class_name => 'Project', :foreign_key => :owner_id, :dependent => :destroy
  has_and_belongs_to_many :contributions, :class_name => 'Project', :join_table => :contributors_projects
  has_and_belongs_to_many :tasks, :join_table => :contributors_tasks
  has_many :comments

  validates_presence_of :name, :username
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^\w*$/

  def projects
    (own_projects + contributions).sort { |x, y| y[:updated_at] <=> x[:updated_at] }
  end

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  end

  # Attempt to find a user by it's email. If a record is found, send new
  # password instructions to it. If not user is found, returns a new user
  # with an email not found error.
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
         login = attributes.delete(:login)
         record = find_record(login)
      else
        record = where(attributes).first
      end
    end

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end
    end
    record
  end

  def self.find_record(login)
    where(["username = :value OR email = :value", { :value => login }]).first
  end
end

