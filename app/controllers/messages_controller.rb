class MessagesController < ApplicationController
  def create
    @message = Message.create(params.require(:message).permit(:room_id, :content).merge(user_id: current_user.id))
    redirect_to "/rooms/#{@message.room_id}"
  end
end
