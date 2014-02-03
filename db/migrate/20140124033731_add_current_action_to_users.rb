class AddCurrentActionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_action_id, :integer
  end
end
