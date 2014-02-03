class AddActionCreatedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :action_created_at, :datetime
  end
end
