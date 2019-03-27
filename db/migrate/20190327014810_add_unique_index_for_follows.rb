class AddUniqueIndexForFollows < ActiveRecord::Migration[5.2]
  def change
    add_index :follows, [:from_user_id, :to_user_id], :unique => true
  end
end
