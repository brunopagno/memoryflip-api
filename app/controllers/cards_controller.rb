class CardsController < ApplicationController
  before_action :authenticate

  def index
    sorting = params[:sort] || "unsorted"

    cards = current_user.cards

    cards = case sorting
    when "random"
      cards.shuffle
    else
      cards
    end

    render json: cards, only: [:id, :front, :back]
  end

  def create
    card = Card.new(card_params)
    card.user = current_user
    if card.save
      head :created
    else
      render json: card.errors, status: :unprocessable_entity
    end
  end

  def update
    card = Card.find(params[:id])
    if card.update(card_params)
      head :ok
    else
      render json: card.errors, status: :unprocessable_entity
    end
  end

  def destroy
    card = Card.find(params[:id])
    if card.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def card_params
    params.require(:card).permit(:front, :back)
  end
end
