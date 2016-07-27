class CreateRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :regions do |t|
      t.string :name

      t.timestamps
    end

    change_table :posts do |t|
      t.references :region
    end
  end
end
