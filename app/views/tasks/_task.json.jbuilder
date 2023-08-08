json.extract! task, :id, :nome, :descrizione, :completato, :created_at, :updated_at
json.url task_url(task, format: :json)
