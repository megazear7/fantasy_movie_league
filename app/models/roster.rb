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
 
end
