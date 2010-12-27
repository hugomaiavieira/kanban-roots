class ContributorsTasks < ActiveRecord::Migration
  def self.up
    create_table :contributors_tasks, :id => false do |t|
      t.references :contributor, :task
    end
  end

  def self.down
    drop_table :contributors_tasks
  end
end

