FactoryBot.define do
  factory :user do
    firstname { 'John' }
    lastname  { 'Doe' }
    username { 'johndoe' }
    email { 'john@emailprovider.com' }
    password { 'Ciao1234!' }
  end
end
