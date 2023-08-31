json.extract! request, :id, :request_id, :note, :stato_accettazione, :created_at, :updated_at
json.url request_url(request, format: :json)
