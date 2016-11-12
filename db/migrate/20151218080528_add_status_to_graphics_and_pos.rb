class AddStatusToGraphicsAndPos < ActiveRecord::Migration
  def change
    add_column :graphics, :status, :string
    add_column :pos, :status, :string
  end
end
