class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie.update_revenue 

    # TMDB does not update fast enough :(
    Tmdb::Api.key("7d02ea92c84971ac221022276eb0c848")
    @movie_info = Tmdb::Movie.detail(@movie.apiid) 
    #@movie.box_office_actual = @movie_info.revenue
    #@movie.name = @movie_info.title
    #@movie.imdb_id = @movie_info.imdb_id
    #@movie.release = Date.parse(@movie_info.release_date)
    #@movie.save

    @casts = Tmdb::Movie.casts(@movie.apiid) 
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_revenues
    Tmdb::Api.key("7d02ea92c84971ac221022276eb0c848")
    Movie.all.each do |movie|
      movie.update_revenue 
    end
    redirect_to movies_url, notice: "All movies have been updated."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(
        :name,
        :box_office_actual,
        :release,
        :apiid
      )
    end
end
