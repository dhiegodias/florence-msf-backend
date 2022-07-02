class AgendaNotFoundException < RuntimeError
  def initialize(id:)
    super("Não foi encontrado a razão de cancelamento de orçamento com id #{id}")
  end
end
