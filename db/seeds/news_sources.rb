news_sources = [
  {
    id: 1,
    name: "G1",
    url: "www.g1.com.br",
    credibility: "confiável"
  },

  {
    id: 2,
    name: "R7",
    url: "www.r7.com",
    credibility: "Noticia tendenciosa"
  },

  {
    id: 3,
    name: "Senado Federal",
    url: "https://www12.senado.leg.br/hpsenado",
    credibility: "Confiável"
  },

  {
    id: 4,
    name: "IBGE",
    url: "https://www.ibge.gov.br/",
    credibility: "confiável"
  },
]

news_sources.each_with_index do |news_source, index|
  next if NewsSource.exists?(id: news_source[:id])

  NewsSource.create(
    id: news_source[:id],
    name: news_source[:name],
    url: news_source[:url],
    credibility: news_source[:credibility]
  )

  prefix = "Criando fontes de noticias:"
  prefix = "√ Criando fontes de noticias criadas:" if index == news_sources.count - 1

  print "#{prefix} #{index + 1} de #{news_sources.count} \r"
end
