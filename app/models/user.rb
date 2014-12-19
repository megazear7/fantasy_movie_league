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

  def friends_and_me
    User.where(id: self.friends.pluck(:id) << self.id)
  end

  def me
    User.where(id: self.id)
  end

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
  
  def won? season
    winning_score = season.rosters.maximum("final_score")
    score = self.rosters.find_by("season_id = ?", season.id).score
    score == winning_score ? true : false
  end

  def self.most_6_month_seasons_finished users
    users.joins(:rosters => :season).where("seasons.end_date - seasons.begin_date > 5").where("seasons.has_ended = true").group("rosters.user_id").order("count_all DESC").count.to_a
  end

  def self.most_6_month_seasons_won users
    tmp = {}
    users.all.each do |user|
      tmp[user.id] = 0
      user.seasons.where("end_date - begin_date > 5").where("seasons.has_ended = true").each do |season|
        if user.won? season
          tmp[user.id] += 1 
        end
      end
    end
    tmp.delete_if {|id, score| score == 0 }
    tmp.sort_by { |id, score| -score }
    tmp.to_a
  end

  def self.high_score_6_month_season users
    tmp = Roster.joins(:season).where(user_id: users.pluck(:id)).where("seasons.end_date - seasons.begin_date > 5").where("seasons.has_ended = true").order("final_score DESC").pluck(:user_id, :final_score)
    tmp.map! { |x| [User.find(x[0]), x[1]] }
  end

  def self.most_points users
    tmp = users.joins(:rosters).group("rosters.user_id").sum("rosters.final_score")
    tmp.delete_if {|id, score| score == 0 }
    tmp.sort_by { |id, score| -score }
  end

  def self.single_season_score_this_year users
    tmp = Roster.joins(:season).where(user_id: users.pluck(:id)).where("seasons.end_date >= ? AND seasons.end_date <= ?", Date.today.beginning_of_year, Date.today.end_of_year).where("seasons.has_ended = true").order("final_score DESC").pluck(:user_id, :final_score)
    tmp.map! { |x| [User.find(x[0]), x[1]] }
  end

  def self.single_6_month_season_score_this_year users
    tmp = Roster.joins(:season).where(user_id: users.pluck(:id)).where("seasons.end_date >= ? AND seasons.end_date <= ?", Date.today.beginning_of_year, Date.today.end_of_year).where("seasons.end_date - seasons.begin_date > 5").where("seasons.has_ended = true").order("final_score DESC").pluck(:user_id, :final_score)
    tmp.map! { |x| [User.find(x[0]), x[1]] }
  end

  def self.seasons_finished users
    users.joins(:rosters => :season).where("seasons.has_ended = true").group("rosters.user_id").order("count_all DESC").count
  end

  def self.seasons_won users
    tmp = {}
    users.all.each do |user|
      tmp[user.id] = 0
      user.seasons.where("seasons.has_ended = true").each do |season|
        if user.won? season
          tmp[user.id] += 1 
        end
      end
    end
    tmp.delete_if {|id, score| score == 0 }
    tmp.sort_by { |id, score| -score }
    tmp.to_a
  end

  def self.highest_score users
    tmp = Roster.joins(:season).where(user_id: users.pluck(:id)).where("seasons.has_ended = true").order("final_score DESC").pluck(:user_id, :final_score)
    tmp.delete_if {|id, score| score == 0 }
    tmp.map! { |x| [User.find(x[0]), x[1]] }
  end
end
