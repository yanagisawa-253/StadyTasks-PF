class EventsController < ApplicationController

  def index
    @events = Event.all
    @event = Event.new
 	  @user = current_user
  end

  def create
  @event = Event.new(event_params)
   if  @event.user_id = current_user.id
   	@event.save
       flash[:notice] = "記録しました"
 	    redirect_to events_path
   else
     render :index
   end
  end

  private
  def event_params
    params.require(:event).permit(:title, :start, :end, :user_id, :body)
  end
end
