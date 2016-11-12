class AddSubstrateToGraphic < ActiveRecord::Migration
  def change
    add_reference :graphics, :substrate, index: true, foreign_key: true
  end
end
