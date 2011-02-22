class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :user_email
      t.string :fullname
      t.integer :disk_quota
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :single_access_token
      t.string :perishable_token
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
      t.boolean :active, :default => false, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
