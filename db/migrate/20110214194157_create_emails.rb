class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.integer :user_id
      t.string :username
      t.string :subject
      t.string :sender_email
      t.string :file_name
      t.string :message_status
      t.boolean :delete_flag

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
