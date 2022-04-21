class CollectionsController < ApplicationController
  before_action :authenticate
  before_action :require_access_to_resource, only: %i[update destroy]
  before_action :require_collection_is_empty, only: %i[destroy]

  def index
    render json: current_user.collections, only: %i[id name]
  end

  def list
    sorting = params[:sort] || 'unsorted'

    cards = current_user.collections.find(params[:id]).cards

    cards = case sorting
            when 'random'
              cards.shuffle
            else
              cards
            end

    render json: cards, only: %i[id front back]
  end

  def create
    collection = Collection.new(collection_params)
    collection.user = current_user

    if collection.save
      head :created
    else
      render json: collection.errors, status: :unprocessable_entity
    end
  end

  def update
    if @collection.update(collection_params)
      head :ok
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @collection.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:name)
  end

  def require_access_to_resource
    @collection = Collection.find(params[:id])
    render :unauthorized unless @collection.user.id == current_user.id
  end

  def require_collection_is_empty
    render json: { error: 'collection is not empty' }, status: :unprocessable_entity unless @collection.cards.empty?
  end
end
