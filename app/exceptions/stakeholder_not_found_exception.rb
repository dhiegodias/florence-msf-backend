class StakeholderNotFoundException < RuntimeError
  def initialize(id:)
    super("Não foi possível encontrar stakeholder com id #{id}")
  end
end