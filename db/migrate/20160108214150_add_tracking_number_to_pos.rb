class AddTrackingNumberToPos < ActiveRecord::Migration
  def change
    add_column :pos, :tracking_number, :string
  end
end