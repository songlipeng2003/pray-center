class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :username, after: :id
      t.index :username, unique: true
    end
  end
end
