class TilesController < ApplicationController

  def all
    @tiles = Tile.order("created_at DESC").all
    render json: @tiles
  end

  def new
    @tile = Tile.new
    @user = current_user
    gon.currentUser = @user
    render :new
  end

  def index
    @tiles = Tile.order("created_at DESC").where(user_id: params[:user_id])
    render json: @tiles
  end

  def show
    @tile = Tile.find(params[:id])
    render json: @tile
  end

  def create
    @tile = Tile.new(tile_params)
    if current_user.post(@tile) # Tile is saved with a reference to the current_user
      render json: @tile
    else
      render status: 400, nothing: true
    end
  end

  def destroy
    @tile = Tile.find(params[:id])
    if @tile.destroy
      render json: {}
    else
      render status: 400, nothing: true
    end
  end

  private

  def tile_params
    params.require(:tile).permit(:message, :sound_id, :color, :user_id)
  end

end