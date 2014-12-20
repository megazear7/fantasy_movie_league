namespace :movies do

  task add_upoming: :environment do
    Tmdb::Api.key("7d02ea92c84971ac221022276eb0c848")
    Tmdb::Movie.upcoming.each do |movie|
      if not Movie.find_by(apiid: movie.id).present?
        m = Movie.new
        m.apiid = movie.id
        m.name = movie.title
        m.imdb_id = movie["imdb_id"]
        m.release = Date.parse(movie.release_date)
        m.box_office_actual = 0
        m.save
      end
    end
  end


  task add_between: :environment do

    begin_date = ENV['begin'] ? ENV['begin'] : "2014-12-01"
    end_date   = ENV['end']   ? ENV['end']   : "2014-12-04"

    headers = {
     :accept => 'application/json'
    }

    response = RestClient.get "http://api.themoviedb.org/3/discover/movie?api_key=7d02ea92c84971ac221022276eb0c848&release_date.gte=#{begin_date}&release_date.lte=#{end_date}", headers

    tmp = JSON.parse(response)

    puts "Total Results: " + tmp["total_results"].to_s
    puts "Total Pages: " + tmp["total_pages"].to_s
    
    (1..tmp["total_pages"]).each do |page_num|
      raw_movies = RestClient.get "http://api.themoviedb.org/3/discover/movie?api_key=7d02ea92c84971ac221022276eb0c848&release_date.gte=#{begin_date}&release_date.lte=#{end_date}", headers
      movies = JSON.parse(raw_movies)
      movies["results"].each do |movie|
        if not Movie.find_by(apiid: movie["id"]).present?
          begin
            puts movie["title"]
            m = Movie.new
            m.apiid = movie["id"]
            m.name = movie["title"]
            m.imdb_id = movie["imdb_id"]
            m.release = Date.parse(movie["release_date"])
            m.box_office_actual = 0
            m.save
          rescue
            puts red("FAILED: " + movie["title"])
          end
        end
      end
    end
  end

  task add_all: :environment do

    year = ENV['year'] ? ENV['year'] : 2015

    headers = {
     :accept => 'application/json'
    }

    response = RestClient.get "http://api.themoviedb.org/3/discover/movie?api_key=7d02ea92c84971ac221022276eb0c848&primary_release_year=#{year}", headers

    tmp = JSON.parse(response)

    puts "Total Results: " + tmp["total_results"].to_s
    puts "Total Pages: " + tmp["total_pages"].to_s
    
    (1..tmp["total_pages"]).each do |page_num|
      raw_movies = RestClient.get "http://api.themoviedb.org/3/discover/movie?api_key=7d02ea92c84971ac221022276eb0c848&primary_release_year=#{year}&page=#{page_num}", headers
      movies = JSON.parse(raw_movies)
      movies["results"].each do |movie|
        if not Movie.find_by(apiid: movie["id"]).present?
          begin
            puts movie["title"]
            m = Movie.new
            m.apiid = movie["id"]
            m.imdb_id = movie["imdb_id"]
            m.name = movie["title"]
            m.release = Date.parse(movie["release_date"])
            m.box_office_actual = 0
            m.save
          rescue
            puts red("FAILED: " + movie["title"])
          end
        end
      end
    end
  end
end
