class AddInInvoicingToPo < ActiveRecord::Migration
  def change
    add_column :pos, :in_invoicing, :boolean, default: false, index: true
  end
end
