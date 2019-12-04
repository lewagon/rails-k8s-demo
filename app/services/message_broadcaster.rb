class MessageBroadcaster
  def self.call(message)
    new(message).broadcast_message
  end

  def initialize(message)
    @message = message
  end

  def broadcast_message
    ActionCable.server.broadcast(
      "messages",
      type: "message",
      id: @message.id,
      author: @message.author,
      html: ApplicationController.renderer.render(
        partial: "messages/message",
        locals: {message: @message}
      )
    )
  end
end
