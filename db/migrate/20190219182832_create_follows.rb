class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.references :from_user
      t.references :to_user
      t.timestamps
    end
  end
end
