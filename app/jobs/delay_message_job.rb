class DelayMessageJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    @message = Message.find(message_id)
    @message.update(displayed: true)
    Sidekiq.logger.info "#{@message.content} shown afer #{@message.delay} ms delay"
  end
end
