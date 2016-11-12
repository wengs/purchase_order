class Activity < ActiveRecord::Base
  has_many :activities_graphics
  has_many :graphics, through: :activities_graphics

  has_many :activities_pos
  has_many :pos, through: :activities_pos
end