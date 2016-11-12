class AddGraphicAmended < ActiveRecord::Migration
  def change
    add_column :pos, :graphic_amended, :boolean, default: false
  end
end
