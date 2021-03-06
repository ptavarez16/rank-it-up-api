class PlayersController < OpenReadController
  before_action :set_player, only: %i[show update destroy]

  # GET /players
  def index
    @players = current_user.players

    render json: @players
  end

  # GET /players/1
  def show
    render json: @player
  end

  def most_wins
    @player = current_user.players

    @king_of_games = @player.limit(10).order('wins::integer desc')

    render json: @king_of_games
  end

  # POST /players
  def create
    @player = current_user.players.build(player_params)

    if @player.save
      render json: @player, status: :created, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = current_user.players.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def player_params
    params.require(:player).permit(:name, :description, :wins, :losses)
  end

  def base_query
    Player.where('user_id = :user', user: current_user.id)
  end

  private :set_player, :player_params, :base_query
end
