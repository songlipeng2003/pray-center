class AddOnlineAtToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.datetime :online_at
    end
  end
end
