class Stakeholder < ApplicationRecord
  validates :name, presence: true

  SUPPORTER = "supporter".freeze
  OPPOSITION = "opposition".freeze
  UNDECIDED = "undecided".freeze

  def is_supporter?
    self.role == SUPPORTER
  end

  def is_opposition?
    self.role == OPPOSITION
  end

  def is_undecided?
    self.role == UNDECIDED
  end
end