require 'open-uri'

class Movie < ActiveRecord::Base
  has_many :rosters

  def update_revenue
    begin
      doc = Nokogiri::HTML(open("http://www.imdb.com/title/#{self.imdb_id}/"))
      text = doc.search("[text()*='Gross:']").first.parent.text
      currency_str = text[/\$(([1-9]\d{0,2}(,\d{3})*)|(([1-9]\d*)?\d))(\.\d\d)?/]
      currency_str.remove!("$")
      currency_str.remove!(",")
      self.box_office_actual = currency_str
      self.save
    rescue
    end
  end

  def self.movie_at loc, begin_date, end_date
    Movie.ordered_movies(begin_date, end_date)[loc-1]
  end

  def self.ordered_movies begin_date, end_date
    Movie.where("release > ? AND release < ?", begin_date, end_date).order("box_office_actual DESC")
  end

  def self.movies_between begin_date, end_date
    Movie.where("release > ? AND release < ?", begin_date, end_date)
  end

  def self.ordered_movies_all_time
    Movie.order("box_office_actual DESC")
  end

  def self.top_ten_for begin_date, end_date
    ordered_movies(begin_date, end_date).to_a.first(10)
  end
end
