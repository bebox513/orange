class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = current_user.entries
  end

  def show
    @room = Room.find(params[:id])
    @entries = @room.entries
    @message = Message.new
    @messages = @room.messages
  end

  def new
    @matchers = current_user.followers & current_user.followings
    @room = Room.new
    @entry = Entry.new
  end

  def create
    room = Room.create(room_params)
    Entry.create(user_id: current_user.id, room_id: room.id)
    entry_params[:entries][:user_ids].each do |id|
      entry = Entry.new
      entry.room_id = room.id
      entry.user_id = id
      entry.save
    end
    redirect_to "/rooms/#{room.id}"
  end

  def destroy


  end

  def room_params
    params.require(:room).permit(:name)
  end

  def entry_params
    params.require(:room).permit(entries: [user_ids: []])
  end
end
