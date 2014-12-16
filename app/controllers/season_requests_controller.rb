class SeasonRequestsController < ApplicationController
  before_action :set_season_request, only: [:show, :edit, :update, :destroy, :accept]

  # GET /season_requests
  # GET /season_requests.json
  def index
    @season_requests = SeasonRequest.all
  end

  # GET /season_requests/1
  # GET /season_requests/1.json
  def show
  end

  # GET /season_requests/new
  def new
    @season_request = SeasonRequest.new
  end

  # GET /season_requests/1/edit
  def edit
  end

  # POST /season_requests
  # POST /season_requests.json
  def create
    @season_request = SeasonRequest.new(season_request_params)

    respond_to do |format|
      if @season_request.save
        format.html { redirect_to season_requests_path, notice: 'Season request was successfully created.' }
        format.json { render :show, status: :created, location: @season_request }
      else
        format.html { render :new }
        format.json { render json: @season_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /season_requests/1
  # PATCH/PUT /season_requests/1.json
  def update
    respond_to do |format|
      if @season_request.update(season_request_params)
        format.html { redirect_to season_requests_path, notice: 'Season request was successfully updated.' }
        format.json { render :show, status: :ok, location: @season_request }
      else
        format.html { render :edit }
        format.json { render json: @season_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /season_requests/1
  # DELETE /season_requests/1.json
  def destroy
    @season_request.destroy
    respond_to do |format|
      format.html { redirect_to season_requests_url, notice: 'Season request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def accept
    if not @season_request.season.finalized
      user = User.find(@season_request.requestee.id)
      roster = user.rosters.create(user_id: user.id, season_id: @season_request.season.id)

      @season_request.destroy
      redirect_to edit_roster_path(roster)
    else
      redirect_to @season_request.season
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season_request
      @season_request = SeasonRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def season_request_params
      params.require(:season_request).permit(
        :season_id,
        :requester_id,
        :requestee_id,
        :message
      )
    end
end
