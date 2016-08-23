class ModifyUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.references :region, index: true
      t.remove :area
    end
  end
end
