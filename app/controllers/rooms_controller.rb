class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @messages = @room.messages
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.create(room_params)
    @user = User.find_by(name: @room.name)
    @entry1 = Entry.create(user_id: current_user.id, room_id: @room.id)
    @entry2 = Entry.create(user_id: @user.id, room_id: @room.id)
    redirect_to "/rooms/#{@room.id}"
  end

  def destroy


  end

  def room_params
    params.require(:room).permit(:name)
  end


end
