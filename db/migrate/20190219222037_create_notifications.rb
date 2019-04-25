class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :from_user
      t.references :to_user
      t.references :tweet

      t.string :notification_type
      t.timestamps
    end
  end
end
