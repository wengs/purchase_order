class ActivitiesPo < ActiveRecord::Base
  belongs_to :activity
  belongs_to :po
end