class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Contributor'
  has_and_belongs_to_many :contributors
  has_many :tasks, :dependent => :destroy
  has_many :categories, :dependent => :delete_all

  validates_presence_of :name, :owner_id
  validates_format_of :name,
                      :with    => /^[A-Z0-9 _\-]*$/i,
                      :message => "must include only letters, digits, underscores or hyphens"
  validate :uniqueness_of_project_name_by_owner

  attr_reader :contributor_tokens

  before_save :downcase_name

  def contributor_tokens= ids
    self.contributor_ids = ids.split(',')
  end

  def all_contributors
    [owner] + contributors
  end

  def contributors_scores
    list = []
    tasks = self.tasks_by_position Board::POSITIONS['done']

    all_contributors.each do |contributor|
      tasks_for_contributor = tasks.select { |task| task.contributors.include? contributor }
      points = 0
      tasks_for_contributor.each do |task|
        if task.points
          task.points.zero? ? points += 0.1 : points += task.points
        end
      end
      points = points.round(1) if not points.zero?
      list << { :contributor => contributor, :scores => points }
    end

    list.sort { |x, y| y[:scores] <=> x[:scores] }
  end

  def contributors_for_token_input
    (contributors.map { |c| { :id => c.id, :name => c.name} }).to_json
  end

  def tasks_by_position position
    tasks.select {|item| item.position == position }
  end

  def clean_up_done_tasks
    done_tasks = self.tasks_by_position Board::POSITIONS['done']
    done_tasks.each { |task| task.update_attributes :position => Board::POSITIONS['out'] }
  end

  def count_points position
    points = 0
    self.tasks_by_position(position).each do |task|
      points += task.points if task.points
    end
    points
  end

  def <=> project
    self.name <=> project.name
  end

  private

  def downcase_name
    name.try(:downcase!)
  end

  def uniqueness_of_project_name_by_owner
    return unless owner
    if owner.reload.own_projects.map(&:name).include?(name.try(:downcase))
      errors.add(:owner_id, 'already has a project with the same name')
    end
  end
end

