class AddDueDateToPo < ActiveRecord::Migration
  def change
    add_column :pos, :due_date, :date, index: true
  end
end
