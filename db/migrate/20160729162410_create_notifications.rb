class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :actor, index: true
      t.string :type
      t.references :target, polymorphic: true
      t.references :second_target, polymorphic: true
      t.string :content

      t.timestamps
    end
  end
end
