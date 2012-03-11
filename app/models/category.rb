class Category < ActiveRecord::Base
  has_many :tasks
  belongs_to :project

  validates_presence_of :name, :color, :project_id
  validate :validate_uniqueness_of_color_for_project,
           :validate_uniqueness_of_name_for_project

  validates_format_of :color, :with => /^[a-f0-9]{6}$/i
  validates_format_of :name, :with => /^[a-z]+([\/| |_|-][a-z]+)*$/i

  def validate_uniqueness_of_color_for_project
    categories = Category.where(:project_id => self.project_id)
    colors = categories.collect(&:color)
    if self.id.nil? and colors.include? self.color
      errors.add(:color, 'should be uniq for project')
    end
  end

  def validate_uniqueness_of_name_for_project
    categories = Category.where(:project_id => self.project_id)
    names = categories.collect(&:name)
    if self.id.nil? and names.include? self.name
      errors.add(:name, 'should be uniq for project')
    end
  end

  def name_as_css_class
    self.name.downcase.gsub(/\/| |-/, '_')
  end
end

