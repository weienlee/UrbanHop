class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :action
      t.integer :location_id
      t.boolean :virgin, :default => false

      t.timestamps
    end
    add_index :actions, :location_id
  end
end
