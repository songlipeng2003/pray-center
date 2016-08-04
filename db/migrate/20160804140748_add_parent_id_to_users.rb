class AddParentIdToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.references :parent, index: true
    end
  end
end
