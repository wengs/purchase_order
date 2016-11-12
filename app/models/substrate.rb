class Substrate < ActiveRecord::Base
  has_many :graphics

  before_destroy :has_graphics

  def has_graphics
    return true unless graphics.present?
    errors.add :base, "Cannot delete Substrate that belongs to graphics"

    false
  end
end
