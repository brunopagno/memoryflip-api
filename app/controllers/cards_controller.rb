class CardsController < ApplicationController
  before_action :authenticate
  before_action :require_access_to_resource, only: %i[destroy]

  def create
    card = Card.new(card_params)

    collection = Collection.find(params[:collection_id])
    render :unauthorized unless collection.user.id == current_user.id

    if card.save
      head :created
    else
      render json: card.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @card.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def card_params
    params.require(:card).permit(:front, :back, :collection_id)
  end

  def require_access_to_resource
    @card = Card.find(params[:id])
    render :unauthorized unless @card.collection.user.id == current_user.id
  end
end
