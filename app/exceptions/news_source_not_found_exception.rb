class NewsSourceNotFoundException < RuntimeError
  def initialize(id:)
    super("Não foi encontrado a fonte de notícias com id #{id}")
  end
end