class RostersController < ApplicationController
  before_action :set_roster, only: [:show, :edit, :update, :destroy, :finalize]

  # GET /rosters
  # GET /rosters.json
  def index
    @rosters = Roster.all
  end

  # GET /rosters/1
  # GET /rosters/1.json
  def show
  end

  # GET /rosters/new
  def new
    @roster = Roster.new
  end

  # GET /rosters/1/edit
  def edit
  end

  # POST /rosters
  # POST /rosters.json
  def create
    @roster = Roster.new(roster_params)

    respond_to do |format|
      if @roster.save
        format.html { redirect_to @roster, notice: 'Roster was successfully created.' }
        format.json { render :show, status: :created, location: @roster }
      else
        format.html { render :new }
        format.json { render json: @roster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rosters/1
  # PATCH/PUT /rosters/1.json
  def update
    respond_to do |format|
      if @roster.update(roster_params)
        format.html { redirect_to @roster, notice: 'Roster was successfully updated.' }
        format.json { render :show, status: :ok, location: @roster }
      else
        format.html { render :edit }
        format.json { render json: @roster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rosters/1
  # DELETE /rosters/1.json
  def destroy
    @roster.destroy
    respond_to do |format|
      format.html { redirect_to rosters_url, notice: 'Roster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def finalize
    if not @roster.movie_one.nil? and
       not @roster.movie_two.nil? and
       not @roster.movie_three.nil? and
       not @roster.movie_four.nil? and
       not @roster.movie_five.nil? and
       not @roster.movie_six.nil? and
       not @roster.movie_seven.nil? and
       not @roster.movie_eight.nil? and
       not @roster.movie_nine.nil? and
       not @roster.movie_ten.nil? and
       not @roster.darkhorse_one.nil? and
       not @roster.darkhorse_two.nil? and
       not @roster.darkhorse_three.nil?
       @roster.finalized = true
       @roster.save
    end
    redirect_to @roster, notice: "All selections must be made in order to finalize a roster"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_roster
      @roster = Roster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roster_params
      params.require(:roster).permit(
        :finalized,
        :final_score,
        :user_id,
        :season_id,
        :movie_one_id,
        :movie_two_id,
        :movie_three_id,
        :movie_four_id,
        :movie_five_id,
        :movie_six_id,
        :movie_seven_id,
        :movie_eight_id,
        :movie_nine_id,
        :movie_ten_id,
        :darkhorse_one_id,
        :darkhorse_two_id,
        :darkhorse_three_id
      )
    end
end
