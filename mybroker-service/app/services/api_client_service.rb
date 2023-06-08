require 'net/http'
require 'uri'
require 'json'
class ApiClientService
  url = URI.parse(ENV["API_URL"])
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true # Enable SSL/TLS if needed

  headers = {
    'X-Api-Key' => ENV["API_KEY"],
    'Content-Type' => 'application/json'
  }

  data = {
    "annualRevenue": 80000,
    "enterpriseNumber": "0649885171",
    "legalName": "example SA",
    "naturalPerson": true,
    "nacebelCodes": ["62010", "62020", "62030", "62090", "63110"]
  }

  request = Net::HTTP::Post.new(url.path, headers)
  request.body = data.to_json

  response = http.request(request)

  if response.code == '200'
    result = JSON.parse(response.body)
    # Process the result as needed
    puts result
  else
    puts "Request failed with response code: #{response.code}"
  end
end
