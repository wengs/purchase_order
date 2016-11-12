class AddNotesProductionToPo < ActiveRecord::Migration
  def change
    add_column :pos, :notes_production, :text
  end
end
