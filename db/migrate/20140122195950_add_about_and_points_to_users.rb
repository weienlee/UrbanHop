class AddAboutAndPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    add_column :users, :points, :integer, default: 0
  end
end
