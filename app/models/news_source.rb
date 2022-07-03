class NewsSource < ApplicationRecord
  validates :name, :url, presence: true
end
