class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :reason
      t.datetime :scheduled_on
      t.integer :user_id
      t.integer :company_id

      t.timestamps
    end
  end
end
