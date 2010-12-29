class CreateContributors < ActiveRecord::Migration
  def self.up
    create_table(:contributors) do |t|
      t.string :name
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable

      # t.trackable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :contributors, :email,                :unique => true
    add_index :contributors, :reset_password_token, :unique => true
    # add_index :contributors, :confirmation_token,   :unique => true
    # add_index :contributors, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :contributors
  end
end

