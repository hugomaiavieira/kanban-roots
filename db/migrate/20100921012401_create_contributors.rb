class CreateContributors < ActiveRecord::Migration
  def self.up
    create_table(:contributors) do |t|
      t.string :name
      t.string :username

      ## Devise: Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Devise: Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Devise: Rememberable
      t.datetime :remember_created_at

      t.timestamps
    end

    add_index :contributors, :email,                :unique => true
    add_index :contributors, :reset_password_token, :unique => true
  end

  def self.down
    drop_table :contributors
  end
end

