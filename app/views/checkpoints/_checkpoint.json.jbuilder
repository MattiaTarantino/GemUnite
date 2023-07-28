json.extract! checkpoint, :id, :nome, :descrizione, :completato, :created_at, :updated_at
json.url checkpoint_url(checkpoint, format: :json)
