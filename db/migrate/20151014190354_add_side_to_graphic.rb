class AddSideToGraphic < ActiveRecord::Migration
  def change
    add_reference :graphics, :side, index: true, foreign_key: true
  end
end
