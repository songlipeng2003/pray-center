class AddAuthenticationTokenToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :authentication_token
    end
  end
end
