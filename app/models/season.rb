class Season < ActiveRecord::Base
  belongs_to :user # this is the season "owner"
  has_many :rosters
  validate :has_valid_start_date

  def has_valid_start_date
    errors.add(:end_date, "End date must be atleast 7 days after start date") if (self.end_date - self.begin_date) < 7
    errors.add(:start_date, "Start date must not be in the past") if self.begin_date < Date.today
  end

  def roster_for user
    self.rosters.find_by(user_id: user.id)
  end
end
