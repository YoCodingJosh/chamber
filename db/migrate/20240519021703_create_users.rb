class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      # email address, required for obvious reasons
      t.string :email, null: false

      # username, required for obvious reasons
      t.string :username, null: false

      # password digest, required for obvious reasons
      t.string :password_digest, null: false

      # confirmation token, required for email confirmation, nullable because once the user confirms their email, this field is no longer needed
      t.string :confirmation_token, null: true

      # confirmation sent at, required for email confirmation
      t.datetime :confirmation_sent_at, null: true

      # confirmed at, required for email confirmation
      # nullable because if the user hasn't confirmed their email, this field will be null
      t.datetime :confirmed_at, null: true
    end
  end
end
