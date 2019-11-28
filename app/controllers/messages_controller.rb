class MessagesController < ApplicationController
  def index
    @messages = Message.displayed.last(20).reverse
  end

  def create
    @message = Message.new(message_params)
    @message.author = Current.username
    if @message.save
        DelayMessageJob.perform_later(@message.id, @message.author)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :delay)
  end
end
