class AddUploaderColumnsToPos < ActiveRecord::Migration
  def change
    add_column :pos, :purchase_order, :string
    add_column :pos, :quote, :string
    add_column :pos, :invoice, :string
  end
end
