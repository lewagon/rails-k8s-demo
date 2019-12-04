class MessagesController < ApplicationController
  def index
    @messages = Message.includes(:previews).last(20)
  end

  def create
    @message = Message.new(message_params)
    @message.author = Current.username
    if @message.save
      DeliverMessageJob.perform_later(@message.id)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :delay)
  end
end
