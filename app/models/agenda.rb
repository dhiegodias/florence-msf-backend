class Agenda < ApplicationRecord
  validates :title, presence: true
  has_many :stakeholders
end