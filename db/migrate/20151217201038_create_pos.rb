class CreatePos < ActiveRecord::Migration
  def change
    create_table :pos do |t|
      t.string :job_code
      t.string :po_code
      t.string :event_name
      t.date :shipped_at
      t.datetime :delivered_at
      t.text :shipping_instructions
      t.decimal :price, precision: 10, scale: 2
      t.timestamps null: false
    end
  end
end
