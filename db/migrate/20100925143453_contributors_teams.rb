class ContributorsTeams < ActiveRecord::Migration
  def self.up
    create_table :contributors_teams, :id => false do |t|
      t.references :contributor, :team
    end
  end

  def self.down
    drop_table :contributors_teams
  end
end

