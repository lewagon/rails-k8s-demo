class Message < ApplicationRecord
  scope :displayed, -> { where(displayed: true) }

  validates :content, presence: true
end
