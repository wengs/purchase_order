class CreateGraphics < ActiveRecord::Migration
  def change
    create_table :graphics do |t|
      t.string :graphic_number
      t.string :description
      t.integer :quantity
      t.decimal :height, precision: 8, scale: 2
      t.decimal :width, precision: 8, scale: 2
      t.string :finishing
      t.date :event_at
      t.text :note
      t.string :location
      t.string :hardware_type
      t.decimal :hardware_price, precision: 8, scale: 2
      t.boolean :rush

      t.timestamps null: false
    end
  end
end
