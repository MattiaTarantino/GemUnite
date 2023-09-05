FactoryBot.define do
  factory :project do
    name { 'Progetto Test' }
    info_leader  { 'Info test' }
    dimensione { 4 }
    descrizione { 'Descrizione test' }
    stato { 'iniziato' }
  end
end