class Roster < ActiveRecord::Base
  belongs_to :user
  belongs_to :season

  belongs_to :movie_one, class_name: "Movie"
  belongs_to :movie_two, class_name: "Movie"
  belongs_to :movie_three, class_name: "Movie"
  belongs_to :movie_four, class_name: "Movie"
  belongs_to :movie_five, class_name: "Movie"
  belongs_to :movie_six, class_name: "Movie"
  belongs_to :movie_seven, class_name: "Movie"
  belongs_to :movie_eight, class_name: "Movie"
  belongs_to :movie_nine, class_name: "Movie"
  belongs_to :movie_ten, class_name: "Movie"

  belongs_to :darkhorse_one, class_name: "Movie"
  belongs_to :darkhorse_two, class_name: "Movie"
  belongs_to :darkhorse_three, class_name: "Movie"

  validate :choices_are_unique

  def choices_are_unique
    ids = [movie_one, movie_two, movie_three, movie_four, movie_five, movie_six, movie_seven, movie_eight, movie_nine, movie_ten, darkhorse_one, darkhorse_two, darkhorse_three]
    ids.compact!
    errors.add(:movie_one, "All movies must be unique") if ids.uniq.length != ids.length
  end

  def score
    points = {}
    points["total"] = 0
    if self.finalized
      (1..10).each do |i|
        points["total"] += points_for i
        points[i] = points_for i
      end
      points["d1"] = 0
      points["d2"] = 0
      points["d3"] = 0
      if appears darkhorse_one
        points["total"] += 1
        points["d1"] = 1
      end
      if appears darkhorse_two
        points["total"] += 1
        points["d2"] = 1
      end
      if appears darkhorse_three
        points["total"] += 1
        points["d3"] = 1
      end
    end
    if self.season.has_ended
      points["total"] = self.final_score
    end
    points
  end

  def points_for loc
    movie = loc_to_movie loc
    if spot_on loc, movie
      (loc == 1 or loc == 10) ? 13 : 10
    elsif one_away loc, movie
      7
    elsif two_away loc, movie
      5
    elsif appears movie
      3
    else
      0
    end
  end

  def loc_to_movie loc
    case loc
    when 1 then self.movie_one
    when 2 then self.movie_two
    when 3 then self.movie_three
    when 4 then self.movie_four
    when 5 then self.movie_five
    when 6 then self.movie_six
    when 7 then self.movie_seven
    when 8 then self.movie_eight
    when 9 then self.movie_nine
    when 10 then self.movie_ten
    end
  end

  def spot_on loc, movie
    movie == Movie.movie_at(loc, self.season.begin_date, self.season.end_date)
  end

  def one_away loc, movie
    if loc == 1
      movie == Movie.movie_at(loc,   self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc+1, self.season.begin_date, self.season.end_date)
    elsif loc == 10
      movie == Movie.movie_at(loc,   self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc-1, self.season.begin_date, self.season.end_date)
    else
      movie == Movie.movie_at(loc,   self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc-1, self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc+1, self.season.begin_date, self.season.end_date)
    end
  end

  def two_away loc, movie
    if loc == 1
      movie == Movie.movie_at(loc,   self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc+1, self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc+2, self.season.begin_date, self.season.end_date)
    elsif loc == 2
      movie == Movie.movie_at(loc,   self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc-1, self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc+1, self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc+2, self.season.begin_date, self.season.end_date)
    elsif loc == 9
      movie == Movie.movie_at(loc,   self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc-2, self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc-1, self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc+1, self.season.begin_date, self.season.end_date)
    elsif loc == 10
      movie == Movie.movie_at(loc,   self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc-2, self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc-1, self.season.begin_date, self.season.end_date)
    else
      movie == Movie.movie_at(loc,   self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc-2, self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc-1, self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc+1, self.season.begin_date, self.season.end_date) or
      movie == Movie.movie_at(loc+2, self.season.begin_date, self.season.end_date)
    end
  end

  def appears movie
    movie == Movie.movie_at(1, self.season.begin_date, self.season.end_date) or
    movie == Movie.movie_at(2, self.season.begin_date, self.season.end_date) or
    movie == Movie.movie_at(3, self.season.begin_date, self.season.end_date) or
    movie == Movie.movie_at(4, self.season.begin_date, self.season.end_date) or
    movie == Movie.movie_at(5, self.season.begin_date, self.season.end_date) or
    movie == Movie.movie_at(6, self.season.begin_date, self.season.end_date) or
    movie == Movie.movie_at(7, self.season.begin_date, self.season.end_date) or
    movie == Movie.movie_at(8, self.season.begin_date, self.season.end_date) or
    movie == Movie.movie_at(9, self.season.begin_date, self.season.end_date) or
    movie == Movie.movie_at(10, self.season.begin_date, self.season.end_date)
  end
end
