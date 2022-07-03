class Agenda < ApplicationRecord
  validates :title, presence: true
  has_many :stakeholders

  def to_hash
    {
      id: self.id,
      title: self.title,
      keywords: self.keywords,
      stakeholders: self.stakeholders,
      created_at: self.created_at,
      updated_at: self.updated_at
    }
  end
end