class RemoveUserIdFromSessions < ActiveRecord::Migration[8.0]
  def change
    remove_column :sessions, :user_id, :bigint
  end
end
