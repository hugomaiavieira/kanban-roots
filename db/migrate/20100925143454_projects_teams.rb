class ProjectsTeams < ActiveRecord::Migration
  def self.up
    create_table :projects_teams, :id => false do |t|
      t.references :project, :team
    end
  end

  def self.down
    drop_table :projects_teams
  end
end

