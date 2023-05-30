class RequestedQuote < ApplicationRecord
  belongs_to :subscriber
  validates :subscriber, presence: true
end
