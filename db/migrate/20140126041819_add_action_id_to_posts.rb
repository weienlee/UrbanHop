class AddActionIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :action_id, :integer
  end
end
