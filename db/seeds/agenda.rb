agendas = [
  {
    id: 1,
    title: "Doenças Negligenciadas (Doença de Chagas, Noma)",
    keywords: ["chagas"]
  },

  {
    id: 2,
    title: "Hepatite C ",
    keywords: ["hepatite c"]
  },

  {
    id: 3,
    title: "Acesso a Medicamentos e Propriedade Intelectual",
    keywords: ["acesso a medicamentos", "propriedade intelectual"]
  },

  {
    id: 4,
    title: "Crise climática e desastres socioambientais",
    keywords: ["crise climática", "aquecimento global"]
  },

  {
    id: 5,
    title: "Ajuda Humanitária",
    keywords: ["ajuda humanitária"]
  },

  {
    id: 6,
    title: "Migração e refúgio",
    keywords: ["migração", "refúgio"]
  },
]

agendas.each_with_index do |agenda, index|
  next if Agenda.exists?(id: agenda[:id])

  Agenda.create(
    id: agenda[:id],
    title: agenda[:title],
    keywords: agenda[:keywords]
  )

  prefix = "Criando agendas:"
  prefix = "√ Agendas criadas:" if index == agendas.count - 1

  print "#{prefix} #{index + 1} de #{agendas.count} \r"
end
