class CreateFavoriteUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_users do |t|
      t.references :user
      t.references :favorited_user

      t.timestamps
    end
  end
end
