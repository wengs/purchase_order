class CreateGraphicTypes < ActiveRecord::Migration
  def change
    create_table :graphic_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
