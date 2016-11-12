class CreateGraphicMilestones < ActiveRecord::Migration
  def change
    create_table :graphic_milestones do |t|
      t.references :graphic, index: true, foreign_key: true
      t.references :milestone, index: true, foreign_key: true
      t.text :note

      t.timestamps null: false
    end
  end
end
