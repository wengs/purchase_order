class ReferencePoInGraphics < ActiveRecord::Migration
  def change
    add_reference :graphics, :po, index: true, foreign_key: true
  end
end
