class AddSpecialMilestonesToPo < ActiveRecord::Migration
  def change
    add_column :pos, :ready_for_quote, :boolean, default: false
    add_column :pos, :information_required, :boolean, default: false
    add_column :pos, :files_needed, :boolean, default: false
    add_column :pos, :in_production, :boolean, default: false
  end
end
