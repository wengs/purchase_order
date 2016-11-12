class AddGraphicTypeToGraphic < ActiveRecord::Migration
  def change
    add_reference :graphics, :graphic_type, index: true, foreign_key: true
  end
end
