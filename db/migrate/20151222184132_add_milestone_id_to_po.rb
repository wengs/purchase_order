class AddMilestoneIdToPo < ActiveRecord::Migration
  def change
    remove_column :graphics, :status
    remove_column :pos, :status
    add_reference :pos, :milestone, index: true, foreign_key: true
  end
end
