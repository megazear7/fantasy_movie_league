class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :rosters
  has_many :seasons, through: :rosters
  has_many :seasons_i_run, class_name: "Season", foreign_key: "user_id"
  has_and_belongs_to_many :friends,
          class_name: "User",
          join_table: :friendships,
          foreign_key: :user_id,
          association_foreign_key: :friend_user_id

  def open_friend_requests
    FriendRequest.where(requestee_id: self.id)
  end

  def open_season_requests
    SeasonRequest.where(requestee_id: self.id)
  end

  def admin?
    self.admin_level >= 1
  end

  def active_ongoing_seasons
    self.seasons.where(finalized: true, has_ended: false)
  end

  def past_seasons
    self.seasons.where(has_ended: true)
  end

  def unstarted_seasons
    self.seasons.where(finalized: false)
  end

  def seasons_won
    count = 0
    self.past_seasons.each do |season|
      count += 1 if season.rosters.order("final_score DESC")[0].user == self
    end
    count
  end

  def total_points
    count = 0
    self.past_seasons.each do |season|
      count += season.rosters.find_by(user_id: self.id).score
    end
    count
  end

  def best_finished_season
    self.rosters.order("final_score DESC")[0].season
  end

  def best_finished_season_score
    self.rosters.order("final_score DESC")[0].score
  end


end
