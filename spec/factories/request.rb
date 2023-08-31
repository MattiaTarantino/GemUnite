FactoryBot.define do
    factory :request do
        association :user
        association :project
        note { 'Note test' }
        stato_accettazione { 'In attesa' }
    end
end

