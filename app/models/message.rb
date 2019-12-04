class Message < ApplicationRecord
  has_many :previews, dependent: :destroy
  # gives extract_urls method to message
  include Twitter::TwitterText::Extractor
  validates :content, presence: true

  def urls
    extract_urls(content).map do |url|
      scheme_present?(url) ? url : "http://#{url}"
    end
  end

  private

  def scheme_present?(url)
    URI.parse(url).scheme.present?
  end
end
