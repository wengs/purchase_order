class AddUserIdToGraphic < ActiveRecord::Migration
  def change
    add_column :graphics, :user_id, :integer
  end
end
