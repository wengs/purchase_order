class AddReferenceToPoUser < ActiveRecord::Migration
  def change
    add_reference :pos, :user, index: true, foreign_key: true
  end
end
