class AddScoreToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.integer :score, default: 0
    end
  end
end
