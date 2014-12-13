module RostersHelper

  def movie_choice movie
    movie.nil? ? "Not chosen" : movie.name
  end

end
