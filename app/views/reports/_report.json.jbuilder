json.extract! report, :id, :descrizione, :created_at, :updated_at
json.url report_url(report, format: :json)
