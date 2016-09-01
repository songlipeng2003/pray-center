class AddIsThankToPrayHistories < ActiveRecord::Migration[5.0]
  def change
    change_table :pray_histories do |t|
      t.boolean :is_thanked, default: false
    end
  end
end
