class DenormalizeTweet < ActiveRecord::Migration[5.2]
  def change
    change_table :tweets do |t|
      t.string :username
      t.string :display_name
    end
  end
end
