class CreateGraphicsMilestones < ActiveRecord::Migration
  def change
    drop_table :graphic_milestones
    create_table :graphics_milestones do |t|
      t.references :graphic, index: true, foreign_key: true
      t.references :milestone, index: true, foreign_key: true
      t.text :note

      t.timestamps null: false
    end
    add_index :graphics_milestones, [:graphic_id, :milestone_id], unique: true
  end
end
