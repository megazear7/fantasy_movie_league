class Season < ActiveRecord::Base
  belongs_to :user # this is the season "owner"
  has_many :rosters
end
