class CreateUsers < ActiveRecord::Migration[5.2]
    def change
      create_table :users do |t|
        t.string :username
        t.string :email
        t.string :display_name
        t.string :region
        t.date :date_of_birth
        t.text :bio
        t.string :password

        # TODO: add timestamp
      end
    end
end
