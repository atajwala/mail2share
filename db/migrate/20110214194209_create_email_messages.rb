class CreateEmailMessages < ActiveRecord::Migration
  def self.up
    create_table :email_messages do |t|
      t.integer :email_id
      t.text :email_body

      t.timestamps
    end
  end

  def self.down
    drop_table :email_messages
  end
end
