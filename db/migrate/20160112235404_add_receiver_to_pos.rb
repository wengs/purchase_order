class AddReceiverToPos < ActiveRecord::Migration
  def change
    add_column :pos, :receiver, :string
  end
end
