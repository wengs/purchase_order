class CreateActivitiesGraphics < ActiveRecord::Migration
  def change
    create_table :activities_graphics do |t|
      t.references :activity, index: true, foreign_key: true
      t.references :graphic, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :activities_graphics, [:activity_id, :graphic_id], unique: true
  end
end
