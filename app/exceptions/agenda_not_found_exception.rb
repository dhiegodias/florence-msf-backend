class AgendaNotFoundException < RuntimeError
  def initialize(id:)
    super("Não foi encontrado a agenda com id #{id}")
  end
end
