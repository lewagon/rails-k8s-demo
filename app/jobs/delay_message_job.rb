class DelayMessageJob < ApplicationJob
  queue_as :default

  def perform(message_id, username)
    @message = Message.find(message_id)
    broadcast_message
  end

  private

  def broadcast_message
    ActionCable.server.broadcast(
      "messages",
      id: @message.id,
      html: ApplicationController.renderer.render(
        partial: "messages/message",
        locals: { message: @message }
      )
    )
  end
end
