class CreateAdmins < ActiveRecord::Migration[8.0]
  def change
    create_table :admins do |t|
      t.string :email_address, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
