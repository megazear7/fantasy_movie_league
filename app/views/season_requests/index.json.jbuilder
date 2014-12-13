json.array!(@season_requests) do |season_request|
  json.extract! season_request, :id
  json.url season_request_url(season_request, format: :json)
end
