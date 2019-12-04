class DeliverMessageJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 0 # never retry

  def perform(message_id)
    @message = Message.find(message_id)
    MessageBroadcaster.call(@message)
    count_created = PreviewCreator.call(@message)
    PreviewBroadcaster.call(@message) if count_created.positive?
  end
end
