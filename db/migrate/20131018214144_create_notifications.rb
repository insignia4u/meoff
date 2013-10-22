class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :reason
      t.datetime :scheduled_on
      t.belongs_to :user
      t.belongs_to :company

      t.timestamps
    end
  end
end
