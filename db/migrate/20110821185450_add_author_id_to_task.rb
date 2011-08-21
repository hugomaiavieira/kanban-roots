class AddAuthorIdToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :author_id, :integer
  end

  def self.down
    remove_column :tasks, :author_id
  end
end
