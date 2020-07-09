class EventsController < ApplicationController

  def index
    # @events = Event.all
    @events = Event.only_public.rank(:row_order).all
  end

  def show
    # @event = Event.find(params[:id])
    @event = Event.find_by_friendly_id!(params[:id])
  end

  # def new
  #   @event = Event.new
  # end
  #
  # def create
  #   @event = Event.new(event_params)
  #
  #   if @event.save
  #     redirect_to admin_events_path
  #   else
  #     render "new"
  #   end
  # end

  def event_params
    params.require(:event).permit(:name, :description, :status, :category_id)

  end

end
