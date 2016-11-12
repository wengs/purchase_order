class AddNotesInformationRequiredToGraphics < ActiveRecord::Migration
  def change
    add_column :graphics, :information_required, :boolean, default: false
    add_column :graphics, :notes_information_required, :text
  end
end
