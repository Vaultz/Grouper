json.extract! lien, :id, :name, :url, :created_at, :updated_at
json.url lien_url(lien, format: :json)