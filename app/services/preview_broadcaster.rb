class PreviewBroadcaster
  def self.call(message)
    new(message).broadcast_previews
  end

  def initialize(message)
    @message = message
  end

  def broadcast_previews
    @message.previews.each do |preview|
      broadcast_preview(preview)
    end
  end

  private

  def broadcast_preview(preview)
    ActionCable.server.broadcast(
      "messages",
      type: "preview",
      id: preview.id,
      message_id: preview.message.id,
      html: ApplicationController.renderer.render(
        partial: "previews/preview",
        locals: {preview: preview}
      )
    )
  end
end
