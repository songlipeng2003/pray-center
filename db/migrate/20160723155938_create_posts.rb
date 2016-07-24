class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string :title
      t.text :content
      t.integer :pray_number, default: 0

      t.timestamps
    end
  end
end
