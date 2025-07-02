class AddAdminIdToSessions < ActiveRecord::Migration[8.0]
  def change
    add_column :sessions, :admin_id, :bigint
  end
end
