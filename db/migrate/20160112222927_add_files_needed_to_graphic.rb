class AddFilesNeededToGraphic < ActiveRecord::Migration
  def change
    add_column :graphics, :files_needed, :boolean, default: false
    add_column :graphics, :notes_files_needed, :text
  end
end
