json.extract! comment, :id, :author_id, :body, :photo_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
