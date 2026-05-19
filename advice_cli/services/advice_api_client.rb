require 'net/http'
require 'json'

require_relative '../models/advice'

class AdviceApiClient
  BASE_URL = "https://api.adviceslip.com"

  def random
    response = request("/advice")

    return nil unless response["slip"]

    build_advice(response)
  end

  def search(term)
    response = request("/advice/search/#{term}")

    return [] unless response["slips"]

    response["slips"].map do |slip|
      Advice.new(
        slip["id"],
        slip["advice"]
      )
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
      puts "\nErro ao converter JSON."

      puts response.body[0..300]

      {}
    end
  end

  def build_advice(data)
    slip = data["slip"]

    Advice.new(
      slip["id"],
      slip["advice"]
    )
  end
end