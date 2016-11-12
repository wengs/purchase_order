class CreateSubstrates < ActiveRecord::Migration
  def change
    create_table :substrates do |t|
      t.string :name
      t.decimal :client_cost, precision: 8, scale: 2
      t.decimal :our_cost, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
