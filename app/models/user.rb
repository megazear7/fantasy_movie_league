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
  validates_uniqueness_of :name

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
    if self.rosters.exists?
      self.rosters.order("final_score DESC")[0].season
    else
      nil
    end
  end

  def best_finished_season_score
    if self.rosters.exists?
      self.rosters.order("final_score DESC")[0].score
    else
      0
    end
  end



  def self.most_6_month_seasons_finished
    {"Test User A" => 5, "Test User B" => 5, "Test User C" => 4, "Test User D" => 4, "Test User E" => 4, "Test User F" => 3, "Test User G" => 3}
  end

  def self.most_6_month_seasons_won
    {"Test User A" => 5, "Test User B" => 4, "Test User E" => 4, "Test User C" => 3, "Test User F" => 3}
  end

  def self.high_score_6_month_season
    {"Test User A" => 55, "Test User B" => 53, "Test User C" => 52, "Test User D" => 51, "Test User E" => 50}
  end

  def self.most_points
    {"Test User A" => 345, "Test User B" => 343, "Test User C" => 336, "Test User D" => 334, "Test User E" => 332}
  end

  def self.single_season_score_this_year
    {"Test User A" => 55, "Test User B" => 53, "Test User C" => 52, "Test User D" => 51, "Test User E" => 50}
  end

  def self.single_6_month_season_score_this_year
    {"Test User A" => 55, "Test User B" => 53, "Test User C" => 52, "Test User D" => 51, "Test User E" => 50}
  end

  def self.seasons_finished
    {"Test User A" => 17, "Test User B" => 16, "Test User C" => 16, "Test User D" => 14, "Test User E" => 11}
  end

  def self.seasons_won
    {"Test User A" => 13, "Test User B" => 12, "Test User C" => 12, "Test User D" => 8, "Test User E" => 8}
  end

  def self.highest_score
    {"Test User A" => 55, "Test User B" => 53, "Test User C" => 52, "Test User D" => 51, "Test User E" => 50}
  end







end
