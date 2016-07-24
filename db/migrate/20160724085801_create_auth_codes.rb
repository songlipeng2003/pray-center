class CreateAuthCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :auth_codes do |t|
      t.string :phone
      t.string :code
      t.datetime :expired_at

      t.timestamps
    end
  end
end
