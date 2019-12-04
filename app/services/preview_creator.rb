class PreviewCreator
  def self.call(message)
    new(message).create_previews
  end

  def initialize(message)
    @message = message
  end

  def create_previews
    return 0 unless @message.urls.any?

    attrs = @message.urls.map { |url|
      # This makes an external HTTP call
      # TODO: offload to another job?
      ogp = OpenGraph.new(url)
      {
        title: ogp.title,
        description: ogp.description,
        image_url: ogp.images.first,
        url: url,
      }
    }
    @message.previews.create(attrs)
    @message.previews.count
  end
end
