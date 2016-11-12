class CreateActivitiesPos < ActiveRecord::Migration
  def change
    create_table :activities_pos do |t|
      t.references :activity, index: true, foreign_key: true
      t.references :po, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :activities_pos, [:activity_id, :po_id], unique: true
  end
end
