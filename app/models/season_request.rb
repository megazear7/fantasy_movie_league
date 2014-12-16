class SeasonRequest < ActiveRecord::Base
  belongs_to :season
  belongs_to :requester, class_name: "User"
  belongs_to :requestee, class_name: "User"
  validate :cant_join_same_season_twice

  def cant_join_same_season_twice
    if SeasonRequest.exists?(season: self.season, requestee: requestee, requester: requester) or
       self.requestee.seasons.to_a.include?(self.season)
       errors.add(:requestee_id, "You cannot join the same season twice")
    end
  end

end
