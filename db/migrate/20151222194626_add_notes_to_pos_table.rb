class AddNotesToPosTable < ActiveRecord::Migration
  def change
    add_column :pos, :notes_information_required, :text
    add_column :pos, :notes_file_needed, :text
  end
end
