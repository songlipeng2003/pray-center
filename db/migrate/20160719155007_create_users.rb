class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :gender
      t.date :birth
      t.integer :education
      t.string :job
      t.string :church
      t.string :church_service
      t.date :rebirth
      t.integer :area
      t.string :period

      t.timestamps
    end
  end
end
