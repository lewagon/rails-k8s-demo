class MessagesController < ApplicationController
  def index
    @messages = Message.displayed.order(id: :desc).last(20)
  end

  def create
    @message = Message.new(message_params)
    delay_secs = @message.delay / 1000.to_f
    @message.author = Current.username
    if @message.save
        DelayMessageJob.set(wait: delay_secs.seconds)
                       .perform_later(@message.id)
        redirect_to messages_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :delay)
  end
end
