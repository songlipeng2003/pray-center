class CreatePrayHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :pray_histories do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
