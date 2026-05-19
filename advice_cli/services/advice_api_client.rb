require 'net/http'
require 'json'
require_relative '../models/advice'

class AdviceApiClient
  BASE_URL = "https://api.adviceslip.com"

  def random 
    response = request("/advice")
    build_advice(response)
  end

  def search(term)
    response = request("/advice/search#{term}")
  
    slips = response["slips"] || []
  
    slips.map do |slip|
      Advice.new(slip["id"], slip["advice"])
    end
  end

  private
  
  def request(path)
    uri = URI("#{BASE_URL}#{path}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri)

    request["User-Agent"] = "Ruby Advice CLI"

    response = http.request(request)
    begin
      JSON.parse(response.body)
    rescue JSON::ParserError
      puts "Erro ao converter resposta da API."
      puts response.body

      {}
    end

  end 

  def build_advice(data)
    slip = data["slip"]
    Advice.new(slip["id"], slip["advice"])
  end
end
