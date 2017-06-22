json.extract! suggestion, :id, :document_id, :person_id, :text, :status, :created_at, :updated_at
json.url document_suggestion_url(suggestion, format: :json)
