class EventsController < ApplicationController

 def index
   @events = Event.all
   @event = Event.new
   @user = current_user
 end

 def create
   @event = Event.new(event_params)
   @event.save
     redirect_to events_path
  @events = Event.where(user_id: current_user.id)
 end

 def destroy
   @user = User.find(params[:id])
   event = Event.find(params[:id])
   event.destroy
   redirect_to events_path
 end

 private
   def event_params
     params.require(:event).permit(:title, :start_id, :end, :user_id, :body)
   end
end
