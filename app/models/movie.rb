class Movie < ActiveRecord::Base
  has_many :rosters

  def self.movie_at loc, begin_date, end_date
    Movie.ordered_movies(begin_date, end_date)[loc-1]
  end

  def self.ordered_movies begin_date, end_date
    Movie.where("release > ? AND release < ?", begin_date, end_date).order("box_office_actual DESC")
  end

  def self.ordered_movies_all_time
    Movie.order("box_office_actual DESC")
  end

  def self.top_ten_for begin_date, end_date
    ordered_movies(begin_date, end_date).to_a.first(10)
  end
end
