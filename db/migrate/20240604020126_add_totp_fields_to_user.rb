class AddTotpFieldsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :totp_secret, :string
    add_column :users, :totp_enabled, :boolean, default: false
  end
end
