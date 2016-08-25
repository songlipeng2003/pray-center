class ChangePeriodToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.change :period, :integer
    end
  end
end
