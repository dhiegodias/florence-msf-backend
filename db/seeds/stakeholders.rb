stakeholders = [
  {
    id: 1,
    name: "Daniele Vasconcelos",
    position: "Enfermeira",
    twitter_handler: "danielevasconcelos",
    instagram_handler: "danielevasconcelos",
    role: "supporter",
    phone: "(21) 9 9999-9999",
    email: "danielevasconcelos@teste.com.br",
    organization: "MSF",
    agenda_id: 3
  },

  {
    id: 2,
    name: "Diogenes Santos",
    position: "Enfermeiro",
    twitter_handler: "diogenessantos",
    instagram_handler: "diogenessantos",
    role: "supporter",
    phone: "(21) 9 9999-9999",
    email: "diogenessantos@teste.com.br",
    organization: "MSF",
    agenda_id: 4
  },

  {
    id: 3,
    name: "Carolina Flores",
    position: "Enfermeira",
    twitter_handler: "carolinaflores",
    instagram_handler: "carolinaflores",
    role: "undecided",
    phone: "(21) 9 9999-9999",
    email: "carolinaflores@teste.com.br",
    organization: "MSF",
    agenda_id: 5
  },

  {
    id: 4,
    name: "Lucas Costa",
    position: "Enfermeiro",
    twitter_handler: "lucascosta",
    instagram_handler: "lucascosta",
    role: "undecided",
    phone: "(21) 9 9999-9999",
    email: "lucascosta@teste.com.br",
    organization: "MSF",
    agenda_id: 3
  },

  {
    id: 5,
    name: "Dhiego Dias",
    position: "Enfermeiro",
    twitter_handler: "dhiegodias",
    instagram_handler: "dhiegodias",
    role: "opposition",
    phone: "(21) 9 9999-9999",
    email: "dhiegodias@teste.com.br",
    organization: "MSF",
    agenda_id: 2
  },

  {
    id: 6,
    name: "Florence Nightingale",
    position: "Enfermeira",
    twitter_handler: "florencenightingale",
    instagram_handler: "florencenightingale",
    role: "supporter",
    phone: "(21) 9 9999-9999",
    email: "florencenightingale@teste.com.br",
    organization: "MSF",
    agenda_id: 1
  }
]

stakeholders.each_with_index do |stakeholder, index|
  next if Stakeholder.exists?(id: stakeholder[:id])

  Stakeholder.create(
    id: stakeholder[:id],
    name: stakeholder[:name],
    position: stakeholder[:position],
    twitter_handler: stakeholder[:twitter_handler],
    instagram_handler: stakeholder[:instagram_handler],
    role: stakeholder[:role],
    phone: stakeholder[:phone],
    email: stakeholder[:email],
    organization: stakeholder[:organization],
    agenda_id: stakeholder[:agenda_id]
  )

  prefix = "Criando stakeholders:"
  prefix = "√ Stakeholders criadas:" if index == stakeholders.count - 1

  print "#{prefix} #{index + 1} de #{stakeholders.count} \r"
end