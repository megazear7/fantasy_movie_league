module RostersHelper

  def movie_choice movie
    movie.nil? ? "Not chosen" : link_to(movie.name, movie)
  end

end
