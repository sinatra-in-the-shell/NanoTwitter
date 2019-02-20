class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :tweet
      t.timestamp
    end
  end
end
