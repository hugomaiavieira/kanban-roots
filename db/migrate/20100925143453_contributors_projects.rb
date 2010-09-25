class ContributorsProjects < ActiveRecord::Migration
  def self.up
    create_table :contributors_projects, :id => false do |t|
      t.references :contributor, :project
    end
  end

  def self.down
    drop_table :contributors_projects
  end
end

