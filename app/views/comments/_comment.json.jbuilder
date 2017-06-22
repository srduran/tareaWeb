json.extract! comment, :id, :suggestion_id, :comment_text, :created_at, :updated_at
json.url suggestion_comment_url (comment, format: :json)
