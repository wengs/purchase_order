class AddNumberOfVersionsToGraphics < ActiveRecord::Migration
  def change
    add_column :graphics, :number_of_versions, :integer, default: 1
  end
end
