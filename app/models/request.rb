class Request < ApplicationRecord
  belongs_to :progetto
  belongs_to :utente
end
