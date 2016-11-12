class RemoveGraphicsMilestones < ActiveRecord::Migration
  def change
    drop_table :graphics_milestones
  end
end
