class Season < ActiveRecord::Base
  belongs_to :user # this is the season "owner"
  has_many :rosters

  def roster_for user
    self.rosters.find_by(user_id: user.id)
  end
end
